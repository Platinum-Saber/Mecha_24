'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    // Check if the state column already exists
    const tableDescription = await queryInterface.describeTable('calorie_diary');
    if (!tableDescription.state) {
      // Add the state column to the calorie_diary table
      await queryInterface.addColumn('calorie_diary', 'state', {
        type: Sequelize.ENUM('done', 'missed', 'pending'),
        defaultValue: 'pending',
        allowNull: false
      });
    }

    // Create the trigger to update the state column
    await queryInterface.sequelize.query(`
      CREATE TRIGGER update_calorie_diary_state
      BEFORE UPDATE ON calorie_diary
      FOR EACH ROW
      BEGIN
        IF NEW.date < CURDATE() AND NEW.state = 'pending' THEN
          SET NEW.state = 'missed';
        END IF;
      END;
    `);
  },

  down: async (queryInterface, Sequelize) => {
    // Drop the trigger
    await queryInterface.sequelize.query(`
      DROP TRIGGER IF EXISTS update_calorie_diary_state;
    `);

    // Remove the state column from the calorie_diary table
    await queryInterface.removeColumn('calorie_diary', 'state');
  }
};