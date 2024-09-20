module.exports = (sequelize, DataTypes) => {
    const Snack = sequelize.define('Snack', {
      snack_id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        references: {
          model: 'food_data',
          key: 'food_id'
        }
      }
    }, {
      tableName: 'snacks',
      timestamps: false
    });
  
    return Snack;
  };