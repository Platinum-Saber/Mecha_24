'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    // Drop the ingredients table
    await queryInterface.dropTable('ingredients');

    // Drop the meal_plan table
    await queryInterface.dropTable('meal_plan');
  },

  down: async (queryInterface, Sequelize) => {
    // Recreate the ingredients table
    await queryInterface.createTable('ingredients', {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
      },
      food_id: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: {
          model: 'food_data',
          key: 'food_id'
        }
      },
      meal_plan_id: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: {
          model: 'meal_plan',
          key: 'id'
        }
      },
      quantity: {
        type: Sequelize.DECIMAL(10, 2),
        allowNull: false
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE
      }
    });

    // Recreate the meal_plan table
    await queryInterface.createTable('meal_plan', {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
      },
      user_id: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: {
          model: 'users',
          key: 'id'
        }
      },
      date: {
        type: Sequelize.DATEONLY,
        allowNull: false
      },
      meal_type: {
        type: Sequelize.ENUM('breakfast', 'lunch', 'dinner', 'snack'),
        allowNull: false
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE
      }
    });
  }
};