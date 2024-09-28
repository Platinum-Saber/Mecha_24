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
const CalorieDiary = require('./models/calorie_diary.js')(sequelize, DataTypes);
const UserProfile = require('./models/user_profiles.js')(sequelize, DataTypes);
const Snack = require('./models/snacks.js')(sequelize, DataTypes);

// Set up associations
User.hasOne(UserProfile, { foreignKey: 'user_id', onDelete: 'CASCADE' });
UserProfile.belongsTo(User, { foreignKey: 'user_id', onDelete: 'CASCADE' });
User.hasMany(CalorieDiary, { foreignKey: 'user_id' });
CalorieDiary.belongsTo(User, { foreignKey: 'user_id' });
CalorieDiary.belongsTo(MealPlan, { foreignKey: 'meal_id' });
MealPlan.hasMany(CalorieDiary, { foreignKey: 'meal_id' });
FoodData.hasMany(MealPlan, { as: 'Carb', foreignKey: 'carb_id' });
FoodData.hasMany(MealPlan, { as: 'Protein', foreignKey: 'protein_id' });
FoodData.hasMany(MealPlan, { as: 'Vegetable', foreignKey: 'vegetable_id' });
FoodData.hasMany(MealPlan, { as: 'Other', foreignKey: 'other_id' });
FoodData.hasOne(Snack, { foreignKey: 'snack_id' });
Snack.belongsTo(FoodData, { foreignKey: 'snack_id' });

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


async function handleDeleteUser(req, res) {
  const userId = req.params.userId;
  try {
    // Start a transaction
    const result = await sequelize.transaction(async (t) => {
      // First, delete the user profile
      await UserProfile.destroy({
        where: { user_id: userId },
        transaction: t
      });

      // Then, delete the user
      const deletedUser = await User.destroy({
        where: { user_id: userId },
        transaction: t
      });

      if (deletedUser === 0) {
        throw new Error('User not found');
      }

      // If you have other related data, delete them here
      // For example:
      // await CalorieDiary.destroy({ where: { user_id: userId }, transaction: t });
      // await MealPlan.destroy({ where: { user_id: userId }, transaction: t });

      return deletedUser;
    });
    logger.info(`User deleted successfully: ${userId}`);
    res.status(200).json({ message: 'User deleted successfully' });
  } catch (error) {
    if (error.message === 'User not found') {
      logger.warn(`Attempt to delete non-existent user: ${userId}`);
      return res.status(404).json({ error: 'User not found' });
    }
    logger.error('Error deleting user:', error);
    res.status(500).json({ error: 'Error deleting user', details: error.message });
  }
}

async function handleGetSnacks(res,req) {
  try{
    const snacks = await sequelize.query(
      `SELECT snack_id AS meal_id, name, calories_per_serving as calories
      FROM snacks
      ORDER BY RAND()
      LIMIT 15`,
      {
        type: sequelize.QueryTypes.SELECT
      }
    );

    console.log('Fetched snacks:', snacks);
    return snacks; // Add this line

  } catch (error) {
    logger.error('Error fetching snacks:', error);
    res.status(500).json({ error: 'Error fetching snacks', details: error.message });
  }
}

async function handleGetMeals(req, res) {
  try {
    const meals = await sequelize.query(
      `SELECT 
        meal_id, 
        CONCAT(
          carb_name, ', ', 
          prot_name, ', ', 
          vegi_name,
          CASE WHEN other_name != 'None' THEN CONCAT(', ', other_name) ELSE '' END
        ) AS name,
        ROUND(calc_carb_calorie + calc_prot_calorie + calc_vegi_calorie) AS calories
      FROM meals
      ORDER BY RAND()
      LIMIT 15`,
      {
        type: sequelize.QueryTypes.SELECT
      }
    );

    console.log('Fetched meals:', meals); // Add this line
    const snacks = await handleGetSnacks();
    // Group meals into breakfast, lunch, dinner, and snacks
    const mealPlan = {
      breakfast: meals.slice(0, 3),
      lunch: meals.slice(3, 6),
      dinner: meals.slice(6, 9),
      snack1: snacks.slice(0, 3),
      snack2: snacks.slice(3, 6)
    };

    console.log('Grouped meal plan:', JSON.stringify(mealPlan, null, 2)); // Add this line

    res.json(mealPlan);

  } catch (error) {
    logger.error('Error fetching meals:', error);
    res.status(500).json({ error: 'Error fetching meals', details: error.message });
  }
}

async function handleGetCalorieDiary(res,req) {
  try{
    const { userId, date } = req.params;
    
    const calorieDieryBreakfastRecord = await sequelize.query(
      `SELECT m.carb_name, m.prot_name, m.vegi_name, c.total_calories, m.calc_carb_calorie, m.calc_prot_calorie, m.calc_vegi_calorie
      FROM calorie_diary c
      JOIN meals m ON c.meal_id = m.meal_id
      WHERE c.user_id = ${userId} AND  AND c.meal_time = 'breakfast', c.date = ${date}`,
      {
        type: sequelize.QueryTypes.SELECT
      }
    );
    console.log('Fetched breakfast:', calorieDieryBreakfastRecord);

    const calorieDieryLunchRecord = await sequelize.query(
      `SELECT m.carb_name, m.prot_name, m.vegi_name, c.total_calories, m.calc_carb_calorie, m.calc_prot_calorie, m.calc_vegi_calorie
      FROM calorie_diary c
      JOIN meals m ON c.meal_id = m.meal_id
      WHERE c.user_id = ${userId} AND c.meal_time = 'lunch', c.date = ${date}`,
      {
        type: sequelize.QueryTypes.SELECT
      }
    );
    console.log('Fetched lunch:', calorieDieryLunchRecord);

    const calorieDieryDinnerRecord = await sequelize.query(
      `SELECT m.carb_name, m.prot_name, m.vegi_name, c.total_calories, m.calc_carb_calorie, m.calc_prot_calorie, m.calc_vegi_calorie
      FROM calorie_diary c
      JOIN meals m ON c.meal_id = m.meal_id
      WHERE c.user_id = ${userId} AND c.meal_time = 'dinner', c.date = ${date}`,
      {
        type: sequelize.QueryTypes.SELECT
      }
    );
    console.log('Fetched dinner:', calorieDieryDinnerRecord);

    const calorieDierySnack1Record = await sequelize.query(
      `SELECT s.name, c.total_calories
      FROM calorie_diary c
      JOIN snacks s ON c.snack_id = s.snack_id
      WHERE c.user_id = ${userId} AND c.meal_time = 'snack1', c.date = ${date}`,
      {
        type: sequelize.QueryTypes.SELECT
      }
    );
    console.log('Fetched snack1:', calorieDierySnack1Record);

    const calorieDierySnack2Record = await sequelize.query(
      `SELECT s.name, c.total_calories
      FROM calorie_diary c
      JOIN snacks s ON c.snack_id = s.snack_id
      WHERE c.user_id = ${userId} AND c.meal_time = 'snack2' AND c.date = ${date}`,
      {
        type: sequelize.QueryTypes.SELECT
      }
    );
    console.log('Fetched snack2:', calorieDierySnack2Record);
  
  }catch(error){
    logger.error('Error fetching calorie diary:', error);
    res.status(500).json({ error: 'Error fetching calorie diary', details: error.message });
  }
}

async function handleAddCalorieDiary(req, res) {
  const { userId, date, mealTime, mealId, snackId, totalCalories } = req.body;

  try {
    const calorieDiary = await CalorieDiary.create({
      user_id: userId,
      date,
      meal_time: mealTime,
      meal_id: mealId,
      snack_id: snackId,
      total_calories: totalCalories
    });

    logger.info('Calorie diary added successfully:', calorieDiary.calorie_diary_id);
    res.status(201).json({ message: 'Calorie diary added successfully' });

  } catch (error) {
    logger.error('Error adding calorie diary:', error);
    res.status(500).json({ error: 'Error adding calorie diary', details: error.message });
  }
}


async function handleSaveMealPlan(req, res) {
  const { userId, mealPlan, mealCals } = req.body;

  try {
    const currentDate = new Date().toISOString().split('T')[0]; // Get current date in YYYY-MM-DD format
    console.log('Data to be posted:', userId, mealPlan, mealCals, currentDate);

    // Filter out entries with null meal_id
    const validMealEntries = Object.entries(mealPlan).filter(([mealType, mealId]) => mealId !== 'null');

    // Insert each valid meal into the calorie_diary table
    const promises = validMealEntries.map(async ([mealType, mealId], index) => {
      try {
        await CalorieDiary.create({
          user_id: userId,
          date: currentDate,
          meal_type: mealType.toLowerCase().replace(' ', '_'), // Convert meal type to match ENUM values
          meal_id: mealId,
          total_calories: mealCals[index], // Use the corresponding mealCals value
          state: 'pending'
        });
      } catch (error) {
        logger.error(`Error inserting meal plan entry for ${mealType}:`, error);
        throw error;
      }
    });

    await Promise.all(promises);

    res.status(201).json({ message: 'Meal plan saved successfully' });
  } catch (error) {
    logger.error('Error saving meal plan:', error);
    res.status(500).json({ error: 'Error saving meal plan', details: error.message });
  }
}


// Routes
app.post('/register', validateRegistrationInput, handleRegistration);
app.post('/login', validateLoginInput, handleLogin);
app.get('/user-profile/:userId', handleGetUserProfile);
app.put('/user-profile/:userId', handleUpdateUserProfile);
app.delete('/user/:userId', handleDeleteUser);
app.get('/meals', handleGetMeals);
app.get('/calorie-diary/:userId/:date', handleGetCalorieDiary);
app.post('/calorie-diary', handleAddCalorieDiary);
app.post('/save-meal-plan', handleSaveMealPlan);
 
// Start the server
const PORT = process.env.PORT || 8080;
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