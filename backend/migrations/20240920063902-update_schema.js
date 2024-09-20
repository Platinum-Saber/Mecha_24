'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('snacks', {
      snack_id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        references: {
          model: 'food_data',
          key: 'food_id'
        }
      }
    });

    // Update food_data table
    await queryInterface.changeColumn('food_data', 'type', {
      type: Sequelize.ENUM('carb', 'protein', 'vegetable', 'snack'),
      allowNull: false
    });

    // Update meal_plans table if necessary
    // If there are any changes to meal_plans, add them here

    // Update calorie_diary table if necessary
    // If there are any changes to calorie_diary, add them here
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('snacks');

    // Revert food_data table changes
    await queryInterface.changeColumn('food_data', 'type', {
      type: Sequelize.ENUM('carb', 'protein', 'vegetable'),
      allowNull: false
    });

    // Revert any other changes made in the 'up' function
  }
};