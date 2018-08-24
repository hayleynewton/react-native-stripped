import React from 'react';
import {StyleSheet, Text, TouchableOpacity, ViewPropTypes} from 'react-native';
import PropTypes from 'prop-types';

class RectangularButton extends React.Component {

  handleOnPress() {
    this.props.onClick();
  }

  render() {
    return(
      <TouchableOpacity 
          style={[styles.Container, this.props.style]} 
          disabled={!!this.props.disabled}
          onPress={() => this.handleOnPress()}>
          <Text style={[styles.TextStyle, this.props.textStyle]}>{this.props.title}</Text>
      </TouchableOpacity>
    );
  }
}

RectangularButton.propTypes = {
  title: PropTypes.string.isRequired,
  style: ViewPropTypes.style,
  textStyle: Text.propTypes.style,
  disabled: PropTypes.bool,
  onClick: PropTypes.func.isRequired
};

const styles = StyleSheet.create({
  Container: {
    justifyContent: "center",
    alignItems: "center",
    height: 50,
    borderRadius: 12,
    marginLeft: 5,
    marginRight: 5,
  },

  TextStyle: {
    color: "white",
    fontSize: 20,
    fontFamily: 'SourceSansPro-SemiBold'
  }
})

export default RectangularButton;