'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.changeColumn('user_profiles', 'ethnicity', {
      type: Sequelize.ENUM('sri_lankan', 'south_asian', 'asian', 'non_asian'),
      allowNull: true
    });
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.changeColumn('user_profiles', 'ethnicity', {
      type: Sequelize.STRING,
      allowNull: true
    });
  }
};