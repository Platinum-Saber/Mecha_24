'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  const MealPlan = sequelize.define('MealPlan', {
    meal_id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    carb_id: DataTypes.INTEGER,
    protein_id: DataTypes.INTEGER,
    vegetable_id: DataTypes.INTEGER,
    other_id: DataTypes.INTEGER
  }, {
    tableName: 'meal_plans',
    timestamps: false
  });

  return MealPlan;
};