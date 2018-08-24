import React from 'react';
import {StyleSheet, View, Text, ViewPropTypes} from 'react-native';
import PropTypes from 'prop-types';
import Separator from './Separator.js';

class DashboardScreensLayout extends React.Component {

  render() {

    const {spacingValue} = this.props;
    const headerStyleFromProps = {paddingLeft: spacingValue};
    const separatorStyleFromProps = {marginTop: spacingValue};

    return(
      <View style={[styles.Container]}>
        <View style={headerStyleFromProps}>
          <Text style={styles.Title}>{this.props.title}</Text>
          <Separator style={separatorStyleFromProps} /> 
        </View>
        <View style={[styles.Content, this.props.contentContainerStyle]}>
          {this.props.children}
        </View>
      </View>
    );
  }
}

DashboardScreensLayout.propTypes = {
  title: PropTypes.string,
  children: PropTypes.node,
  spacingValue: PropTypes.number,
  contentContainerStyle: ViewPropTypes.style
};

DashboardScreensLayout.defaultProps = {
  spacingValue: 10
}

const styles = StyleSheet.create({
  Container: {
    flex: 1,
    backgroundColor: 'white'
  },

  Title: {
    fontSize: 30,
    fontWeight: 'bold'
  },
  
  Content: {
    flex: 1
  }
});

export default DashboardScreensLayout;