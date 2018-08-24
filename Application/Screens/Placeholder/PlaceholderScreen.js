import React from 'react';
import {View, StyleSheet} from 'react-native';


class PlaceholderScreen extends React.Component {
  
  render() {

   
    return (
      <View style={styles.Container}>

      </View>
    );
  }
}

const styles = StyleSheet.create({
  Container: {
    flex: 1,
   
  }
});

export default PlaceholderScreen;