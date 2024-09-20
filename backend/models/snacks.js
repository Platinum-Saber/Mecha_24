module.exports = (sequelize, DataTypes) => {
  const Snack = sequelize.define('Snack', {
    snack_id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    name: {
      type: DataTypes.STRING(50),
      allowNull: false,
      unique: true
    },
    calories_per_serving: {
      type: DataTypes.DECIMAL(10, 2),
      allowNull: false
    }
  }, {
    tableName: 'snacks',
    timestamps: false
  });

  return Snack;
};