import React from 'react';
import {createStackNavigator} from 'react-navigation';
import SplashScreen from '../../Screens/Splash/SplashScreen.js';
import PlaceholderScreen from '../../Screens/Placeholder/PlaceholderScreen.js';
import AppStackNavigator from '../../Navigation/AppStackNavigator/AppStackNavigator.js';

const RootStackNavigator = createStackNavigator({
    Splash: SplashScreen,
    AppStackNavigator: AppStackNavigator,
    Placeholder: PlaceholderScreen,
  }, {
    initialRouteName: 'Splash',
    mode: 'card',
    navigationOptions: {
      header: null,
      gesturesEnabled: false
    }
  });

export default RootStackNavigator; 