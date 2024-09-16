module.exports = (sequelize, DataTypes) => {
    const FoodData = sequelize.define('FoodData', {
      food_id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
      },
      name: {
        type: DataTypes.STRING(50),
        allowNull: false
      },
      type: {
        type: DataTypes.ENUM('carb', 'protein', 'vitamin', 'snack'),
        allowNull: false
      },
      calories_per_100g: {
        type: DataTypes.DECIMAL(10, 2),
        allowNull: false
      },
      protein_per_100g: DataTypes.DECIMAL(10, 2),
      carbs_per_100g: DataTypes.DECIMAL(10, 2),
      fat_per_100g: DataTypes.DECIMAL(10, 2),
      fiber_per_100g: DataTypes.DECIMAL(10, 2)
    }, {
      tableName: 'food_data',
      timestamps: false
    });
  
    return FoodData;
  };