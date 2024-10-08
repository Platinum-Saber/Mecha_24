module.exports = (sequelize, DataTypes) => {
  const CalorieDiary = sequelize.define('CalorieDiary', {
    entry_id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    user_id: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    date: {
      type: DataTypes.DATEONLY,
      allowNull: false
    },
    meal_type: {
      type: DataTypes.ENUM('breakfast', 'lunch', 'dinner', 'snack'),
      allowNull: false
    },
    meal_id: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    total_calories: {
      type: DataTypes.DECIMAL(10, 2),
      allowNull: false
    }
  }, {
    tableName: 'calorie_diary',
    timestamps: false
  });

  return CalorieDiary;
};