module.exports = (sequelize, DataTypes) => {
    const UserProfile = sequelize.define('UserProfile', {
      user_id: {
        type: DataTypes.INTEGER,
        primaryKey: true
      },
      gender: {
        type: DataTypes.ENUM('male', 'female', 'other'),
        allowNull: true
      },
      date_of_birth: {
        type: DataTypes.DATEONLY,
        allowNull: true
      },
      height_cm: {
        type: DataTypes.DECIMAL(5, 2),
        allowNull: true
      },
      weight_kg: {
        type: DataTypes.DECIMAL(5, 2),
        allowNull: true
      },
      dietary_preference: {
        type: DataTypes.ENUM('vegetarian', 'non_vegetarian', 'vegan'),
        allowNull: true
      },
      allergies: DataTypes.TEXT,
      ethnicity: {
        type: DataTypes.ENUM('sri_lankan', 'south_asian', 'asian', 'non_asian'),
        allowNull: true
      },
      activity_level: {
        type: DataTypes.ENUM('light', 'moderate', 'active', 'very_active'),
        allowNull: true
      },
      current_calories_per_day: {
        type: DataTypes.INTEGER,
        allowNull: true
      },
      weight_goal: {
        type: DataTypes.ENUM('maintain', 'lose', 'gain'),
        allowNull: true
      },
      target_weight_kg: DataTypes.DECIMAL(5, 2),
      weight_change_rate: DataTypes.ENUM('0', '200', '400', '600', '800')
    }, {
      tableName: 'user_profiles',
      timestamps: false
    });

    UserProfile.associate = (models) => {
      UserProfile.belongsTo(models.User, {
        foreignKey: 'user_id',
        onDelete: 'CASCADE'
      });
    };
  
    return UserProfile;
  };