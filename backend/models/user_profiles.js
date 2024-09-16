module.exports = (sequelize, DataTypes) => {
    const UserProfile = sequelize.define('UserProfile', {
      user_id: {
        type: DataTypes.INTEGER,
        primaryKey: true
      },
      gender: {
        type: DataTypes.ENUM('male', 'female', 'other'),
        allowNull: false
      },
      date_of_birth: {
        type: DataTypes.DATEONLY,
        allowNull: false
      },
      height_cm: {
        type: DataTypes.DECIMAL(5, 2),
        allowNull: false
      },
      weight_kg: {
        type: DataTypes.DECIMAL(5, 2),
        allowNull: false
      },
      dietary_preference: {
        type: DataTypes.ENUM('vegetarian', 'non_vegetarian', 'vegan'),
        allowNull: false
      },
      allergies: DataTypes.TEXT,
      ethnicity: {
        type: DataTypes.ENUM('sri_lankan', 'south_asian', 'asian', 'non_asian'),
        allowNull: false
      },
      activity_level: {
        type: DataTypes.ENUM('light', 'moderate', 'active', 'very_active'),
        allowNull: false
      },
      current_calories_per_day: {
        type: DataTypes.INTEGER,
        allowNull: false
      },
      weight_goal: {
        type: DataTypes.ENUM('maintain', 'lose', 'gain'),
        allowNull: false
      },
      target_weight_kg: DataTypes.DECIMAL(5, 2),
      weight_change_rate: DataTypes.ENUM('slow', 'moderate', 'fast')
    }, {
      tableName: 'user_profiles',
      timestamps: false
    });
  
    return UserProfile;
  };