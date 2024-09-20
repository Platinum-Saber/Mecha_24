module.exports = (sequelize, DataTypes) => {
  const FoodData = sequelize.define('FoodData', {
    food_id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    name: {
      type: DataTypes.STRING(50),
      allowNull: false,
      unique: true
    },
    type: {
      type: DataTypes.ENUM('carb', 'protein', 'vegetable', 'snack'),
      allowNull: false
    },
    calories_per_100g: {
      type: DataTypes.DECIMAL(10, 2),
      allowNull: false
    }
  }, {
    tableName: 'food_data',
    timestamps: false
  });

  return FoodData;
};