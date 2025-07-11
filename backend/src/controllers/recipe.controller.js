const Recipe = require('../models/recipe.model');

exports.getUserRecipes = async (req, res) => {
  try {
    const { userId } = req.params;
    const recipes = await Recipe.find({ user: userId }).populate('doctor');
    res.json({ success: true, recipes });
  } catch (err) {
    res.status(500).json({ success: false, message: err.message });
  }
};

exports.createRecipe = async (req, res) => {
  try {
    const recipe = await Recipe.create(req.body);
    res.json({ success: true, recipe });
  } catch (err) {
    res.status(500).json({ success: false, message: err.message });
  }
}; 