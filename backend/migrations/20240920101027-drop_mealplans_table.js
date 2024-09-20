'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    // Drop the mealplans table
    await queryInterface.dropTable('mealplans');
  },

  down: async (queryInterface, Sequelize) => {
    // Recreate the mealplans table
    await queryInterface.createTable('mealplans', {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false
      },
      mealPlan: {
        type: Sequelize.STRING(255),
        allowNull: true
      },
      calories: {
        type: Sequelize.INTEGER,
        allowNull: true
      },
      createdAt: {
        type: Sequelize.DATE,
        allowNull: false
      },
      updatedAt: {
        type: Sequelize.DATE,
        allowNull: true
      }
    }, {
      charset: 'utf8mb4',
      collate: 'utf8mb4_0900_ai_ci'
    });
  }
};