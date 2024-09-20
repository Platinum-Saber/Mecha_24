'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    // Drop the existing snacks table
    await queryInterface.dropTable('snacks');

    // Create new snacks table
    await queryInterface.createTable('snacks', {
      snack_id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
      },
      name: {
        type: Sequelize.STRING(50),
        allowNull: false,
        unique: true
      },
      calories_per_serving: {
        type: Sequelize.DECIMAL(10, 2),
        allowNull: false
      }
    });

    // Modify food_data table to remove 'snack' from ENUM
    await queryInterface.changeColumn('food_data', 'type', {
      type: Sequelize.ENUM('carb', 'protein', 'vegetable'),
      allowNull: false
    });
  },

  down: async (queryInterface, Sequelize) => {
    // Revert changes to food_data table
    await queryInterface.changeColumn('food_data', 'type', {
      type: Sequelize.ENUM('carb', 'protein', 'vegetable', 'snack'),
      allowNull: false
    });

    // Drop the new snacks table
    await queryInterface.dropTable('snacks');

    // Recreate the original snacks table
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
  }
};