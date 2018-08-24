import React from 'react';
import {createBottomTabNavigator} from 'react-navigation';
import BottomTabNavigatorCustomComponent from './BottomTabNavigatorCustomComponent.js';
import DashboardStackNavigator from '../DashboardStackNavigator/DashboardStackNavigator.js';
import PracticeScreen from '../../Screens/Practice/PracticeScreen.js';

const BottomTabNavigator = createBottomTabNavigator({
  SetDashboard: DashboardStackNavigator,
  Practice: PracticeScreen,
}, {
  tabBarComponent: ({navigation}) => <BottomTabNavigatorCustomComponent navigation={navigation} />,
  initialRouteName: 'SetDashboard',
  backBehavior: 'initialRoute'
});

BottomTabNavigator.navigationOptions = ({navigation}) => {

  currentRouteName = navigation.state.routes[navigation.state.index].routeName;

  if(currentRouteName === 'SetDashboard') {
    return {header: null};
  }
}


export default BottomTabNavigator;

