import React from 'react';
import {StyleSheet, View, Dimensions} from 'react-native';
import RectangularButton from '../../Components/RectangularButton.js';
import * as ColorPallete from '../../ColorPallete.js';

const {height, width} = Dimensions.get('window');

class SplashScreen extends React.Component {

  constructor() {
    super();
    this.state = {
      isLoading: true
    }
  }

  componentDidMount() {
    this.setState({isLoading: false});
  }

  handleOnStart() {
    this.props.navigation.navigate('AppStackNavigator');
  }

  render() {
    return(
      <View style={styles.Container}>
      
        {
          !this.state.isLoading &&
          <RectangularButton 
            title="Start" 
            style={styles.Button}
            textStyle={styles.ButtonText}
            onClick={() => this.handleOnStart()}/>
        }

      </View>
    );
  }
}

const styles = StyleSheet.create({
  Container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },

  Image: {
    height: height,
    width: width,
    paddingLeft: 35
  },

  HeaderContainer: {
    marginTop: 50,
    //marginLeft: 35,
    flexDirection: 'row',
  },

  ScanEyeContainer: {
    height: 90, 
    width: 90,
    backgroundColor: ColorPallete.WHITE,
    borderRadius: 50,
    justifyContent: 'center',
    alignItems: 'center'
  },

  TitleContainer: {
    flex: 1,
    paddingLeft: 20,
    justifyContent: 'center'
  },

  Title: {
    fontSize: 36,
    fontFamily: 'SourceSansPro-SemiBold',
    color: ColorPallete.WHITE
  },

  Separator: {
    backgroundColor: ColorPallete.WHITE,
    height: 3
  },

  LogoContainer: {
    alignItems: 'flex-end',
    paddingRight: 10,
    height: 30,
    width: '100%',
  },

  Logo: {
    height: '100%',
    width: '45%',
    resizeMode: 'contain',
  },

  BottomContent: {
    flex: 1,
    justifyContent: 'flex-end',
  },

  Text: {
    fontSize: 18, 
    fontFamily: 'SourceSansPro-SemiBold',
    color: ColorPallete.WHITE,
    marginBottom: 15,
    marginTop: 15,
    opacity: 0.9
  },

  LoadingTextContainer: {
    height: 90,
    width: '100%',
  },

  Button: {
    backgroundColor: ColorPallete.WHITE,
    height: 50,
    position: 'absolute',
    left: 15, 
    right: 15,
    bottom: 20
  },

  ButtonText: {
    color: ColorPallete.BLACK
  }
});

export default SplashScreen;