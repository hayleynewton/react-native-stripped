import {NavigationActions, StackActions} from 'react-navigation';

function reset(routeName) {
  return StackActions.reset({
    index: 0,
    actions: [NavigationActions.navigate({routeName: routeName})]
  });
}

function replaceWithAnimation(routeName, params) {
  return NavigationActions.navigate({
    routeName: routeName,
    action: []
  })
}

function pop(n) {
  return StackActions.pop({n});
}

function popToTop() {
  return StackActions.popToTop();
}

function back() {
  return NavigationActions.back();
}

export {
  reset,
  pop,
  popToTop,
  back
}