require('dotenv').config();
const express = require('express');
const bcrypt = require('bcrypt');
const { Sequelize, DataTypes } = require('sequelize');
const { body, validationResult } = require('express-validator');
const winston = require('winston');

// Set up Winston logger
const logger = winston.createLogger({
  level: 'info',
  format: winston.format.json(),
  transports: [
    new winston.transports.File({ filename: 'error.log', level: 'error' }),
    new winston.transports.File({ filename: 'combined.log' })
  ]
});

if (process.env.NODE_ENV !== 'production') {
  logger.add(new winston.transports.Console({
    format: winston.format.simple()
  }));
}

// Set up Sequelize with database configuration
const sequelize = new Sequelize(
  process.env.DB_DATABASE,
  process.env.DB_USERNAME,
  process.env.DB_PASSWORD,
  {
    host: process.env.DB_HOST,
    dialect: process.env.DB_DIALECT || 'mysql',
    logging: (msg) => logger.info(msg)
  }
);

// Import models
const User = require('./models/user.js')(sequelize, DataTypes);
const MealPlan = require('./models/meal_plans.js')(sequelize, DataTypes);
const FoodData = require('./models/food_data.js')(sequelize, DataTypes);
const CalorieDiary = require('./models/calory_diary.js')(sequelize, DataTypes);
const UserProfile = require('./models/user_profiles.js')(sequelize, DataTypes);

// Set up associations
User.hasOne(UserProfile, { foreignKey: 'user_id' });
UserProfile.belongsTo(User, { foreignKey: 'user_id' });
User.hasMany(CalorieDiary, { foreignKey: 'user_id' });
CalorieDiary.belongsTo(User, { foreignKey: 'user_id' });
FoodData.hasMany(CalorieDiary, { foreignKey: 'food_id' });
CalorieDiary.belongsTo(FoodData, { foreignKey: 'food_id' });
FoodData.hasMany(MealPlan, { as: 'Carb', foreignKey: 'carb_id' });
FoodData.hasMany(MealPlan, { as: 'Protein', foreignKey: 'protein_id' });
FoodData.hasMany(MealPlan, { as: 'Vitamin', foreignKey: 'vitamin_id' });
FoodData.hasMany(MealPlan, { as: 'Snack', foreignKey: 'snack_id' });

const app = express();
app.use(express.json());

// Input validation middleware
const validateRegistrationInput = [
  body('email').isEmail(),
  body('password').isLength({ min: 6 }),
  body('name').notEmpty()
];

const validateLoginInput = [
  body('email').isEmail(),
  body('password').exists()
];

// Route handlers
async function handleRegistration(req, res) {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    logger.warn('Validation errors:', errors.array());
    return res.status(400).json({ errors: errors.array() });
  }

  const { name, email, password } = req.body;

  try {
    const existingUser = await User.findOne({ where: { email } });
    if (existingUser) {
      logger.info('Email already in use:', email);
      return res.status(409).json({ error: 'Email already in use' });
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    const user = await User.create({
      username: name,
      email: email,
      password_hash: hashedPassword
    });
    
    logger.info('User registered successfully:', user.user_id);
    const userResponse = { id: user.user_id, name: user.username, email: user.email };
    
    res.status(201).json({ message: 'User registered successfully', user: userResponse });
  } catch (error) {
    logger.error('Error registering user:', error);
    res.status(500).json({ error: 'Error registering user', details: error.message });
  }
}

async function handleLogin(req, res) {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  const { email, password } = req.body;

  try {
    const user = await User.findOne({ where: { email } });
    if (!user) {
      return res.status(401).json({ error: 'Invalid email or password' });
    }

    const isMatch = await bcrypt.compare(password, user.password_hash);
    if (!isMatch) {
      return res.status(401).json({ error: 'Invalid email or password' });
    }

    const userProfile = await UserProfile.findOne({ where: { user_id: user.user_id } });

    const userResponse = {
      user_id: user.user_id,
      username: user.username,
      email: user.email,
      profile: userProfile ? {
        gender: userProfile.gender,
        date_of_birth: userProfile.date_of_birth,
        height_cm: userProfile.height_cm,
        weight_kg: userProfile.weight_kg,
        dietary_preference: userProfile.dietary_preference,
        allergies: userProfile.allergies,
        ethnicity: userProfile.ethnicity,
        activity_level: userProfile.activity_level,
        current_calories_per_day: userProfile.current_calories_per_day,
        weight_goal: userProfile.weight_goal,
        target_weight_kg: userProfile.target_weight_kg,
        weight_change_rate: userProfile.weight_change_rate
      } : null
    };

    res.status(200).json({ message: 'Login successful', user: userResponse });
  } catch (error) {
    logger.error('Login error:', error);
    res.status(500).json({ error: 'Error logging in user' });
  }
}

async function handleGetUserProfile(req, res) {
  try {
    const userId = req.params.userId;
    const userProfile = await UserProfile.findOne({ where: { user_id: userId } });

    if (userProfile) {
      res.json(userProfile);
    } else {
      res.status(404).json({ error: 'User profile not found' });
    }
  } catch (error) {
    logger.error('Error fetching user profile:', error);
    res.status(500).json({ error: 'Error retrieving user profile' });
  }
}
async function handleUpdateUserProfile(req, res) {
  const userId = req.params.userId;
  const profileData = req.body;

  // Validate weight_change_rate
  const validWeightChangeRates = ['0', '200', '400', '600', '800'];
  if (profileData.weight_change_rate && !validWeightChangeRates.includes(profileData.weight_change_rate)) {
    return res.status(400).json({ error: 'Invalid weight_change_rate value' });
  }

  try {
    const userProfile = await UserProfile.findOne({ where: { user_id: userId } });
    if (userProfile) {
      await userProfile.update(profileData);
      res.status(200).json({ message: 'Profile updated successfully' });
    } else {
      res.status(404).json({ error: 'User profile not found' });
    }
  } catch (error) {
    logger.error('Error updating user profile:', error);
    res.status(500).json({ error: 'Error updating user profile', details: error.message });
  }
}
// Routes
app.post('/register', validateRegistrationInput, handleRegistration);
app.post('/login', validateLoginInput, handleLogin);
app.get('/user-profile/:userId', handleGetUserProfile);
app.put('/user-profile/:userId', handleUpdateUserProfile);


// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  logger.info(`Server is running on port ${PORT}`);
});

// Error handling for unhandled promises
process.on('unhandledRejection', (reason, promise) => {
  logger.error('Unhandled Rejection at:', promise, 'reason:', reason);
});

app.get('/', (req, res) => {
  res.send('Nutri Mithu API');
});