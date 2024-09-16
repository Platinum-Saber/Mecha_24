require('dotenv').config();
const express = require('express');
const bcrypt = require('bcrypt');
const { Sequelize, DataTypes } = require('sequelize');
const { body, validationResult } = require('express-validator');

// Set up Sequelize with your database configuration
const sequelize = new Sequelize(
  process.env.DB_DATABASE, 
  process.env.DB_USERNAME, 
  process.env.DB_PASSWORD, 
  {
    host: process.env.DB_HOST,
    dialect: process.env.DB_DIALECT || 'mysql', // Default to 'mysql' if not specified
    logging: console.log // Enable logging for debugging
  }
);

// Import models after defining Sequelize instance
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

// Create an instance of Express
const app = express();
app.use(express.json());

// Sync the models with the database
sequelize.sync()
  .then(() => {
    console.log('Database synchronized successfully.');
  })
  .catch(err => {
    console.error('Error synchronizing the database:', err);
  });

// Registration endpoint
app.post('/register', [
  body('email').isEmail(),
  body('password').isLength({ min: 6 }),
  body('name').notEmpty()
], async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  const { name, email, password } = req.body;

  try {
    const hashedPassword = await bcrypt.hash(password, 10);
    const user = await User.create({ name, email, password: hashedPassword });
    res.status(201).json({ message: 'User registered successfully', user });
  } catch (error) {
    res.status(500).json({ error: 'Error registering user' });
  }
});

// Login endpoint
app.post('/login', [
  body('email').isEmail(),
  body('password').exists()
], async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  const { email, password } = req.body;

  try {
    const user = await User.findOne({ where: { email } });
    if (!user) {
      return res.status(400).json({ error: 'Invalid email or password' });
    }

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ error: 'Invalid email or password' });
    }

    const userWithoutPassword = {
      id: user.id,
      name: user.name,
      email: user.email,
      // Add any other fields you want to include
    };

    res.status(200).json({ message: 'Login successful', user: userWithoutPassword });
  } catch (error) {
    res.status(500).json({ error: 'Error logging in user' });
  }
});

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

app.get("/",(req,res)=>{
  res.json("Hello this is the backend")
})

// Get users
app.get('/users', async (req, res) => {
  try {
    const users = await User.findAll();
    res.json(users);
  } catch (error) {
    res.status(500).json({ error: 'Error retrieving users' });
  }
});

// Get ingredients
app.get('/ingredients', async (req, res) => {
  try {
    const ingredients = await Ingredient.findAll();
    res.json(ingredients);
  } catch (error) {
    res.status(500).json({ error: 'Error retrieving ingredients' });
  }
});