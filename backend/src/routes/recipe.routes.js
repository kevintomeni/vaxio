const express = require('express');
const router = express.Router();
const recipeController = require('../controllers/recipe.controller');

router.get('/user/:userId', recipeController.getUserRecipes);
router.post('/', recipeController.createRecipe);

module.exports = router; 