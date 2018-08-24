import React from 'react';
import {createStackNavigator} from 'react-navigation';

import BottomTabNavigator from '../BottomTabNavigator/BottomTabNavigator.js';
import ScanScreen from '../../Screens/Scan/ScanScreen.js';

const AppStackNavigator = createStackNavigator({
    BottomTabNavigator: BottomTabNavigator,
    Scan: ScanScreen
  }, {
    initialRouteName: 'BottomTabNavigator',
    mode: 'modal'
  });

export default AppStackNavigator; 

