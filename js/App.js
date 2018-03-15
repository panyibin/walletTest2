/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  Platform,
  StyleSheet,
  Text,
  View,
  TextInput,
  Button,
  Alert,
  TouchableOpacity
} from 'react-native';

const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n' +
    'Cmd+D or shake for dev menu',
  android: 'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});

const onButtonPress = () => {
   Alert.alert('generate seed');
};

type Props = {};
export default class App extends Component<Props> {
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Create a wallet
        </Text>
        <Text style={styles.instructions}>
          It's your first time using our mobile wallet, so you'll need to either create a new wallet or load an existing one from a seed.
        </Text>
        <Text style={styles.subTitleWallet}>
        Name your wallet
        </Text>
        <TextInput style={styles.textInputWallet}></TextInput>
        <Text style={styles.subTitleSeed}>
        Seed
        </Text>
        <TextInput style={styles.textInputSeed}></TextInput>
        <TouchableOpacity style={styles.seedGenerateButton} onPress={onButtonPress}>
        <Text style={styles.seedGenerateButtonInside}>Generate seed</Text>
        </TouchableOpacity>
      </View>
    );
  }
}

const commonLeftMargin = 35;

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'flex-start',
    //alignItems: 'center',
    backgroundColor: 'blue',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    marginTop: 50,
    color:'white'
  },
  instructions: {
    textAlign: 'left',
    color: 'white',
    marginTop: 15,
    marginBottom: 5,
    marginLeft:35,
    marginRight:35,
  },
  subTitleWallet: {
    textAlign: 'left',
    fontSize:15,
    color: 'white',
    marginTop:50,
    marginLeft:35
  },
  subTitleSeed: {
    textAlign: 'left',
    fontSize:15,
    color: 'white',
    marginTop:50,
    marginLeft:35
  },
  textInputWallet: {
    fontSize:15,
    backgroundColor:'white',
    marginLeft:35,
    marginRight:35,
    marginTop:10
  },
  textInputSeed: {
    fontSize:15,
    backgroundColor:'white',
    marginLeft:35,
    marginRight:35,
    marginTop:10
  },
  seedGenerateButton: {
    // backgroundColor:'green',
    marginLeft:35,
    marginRight:35,
    marginTop:10,
  },
  seedGenerateButtonInside: {
    color:'white',
    // marginRight:35,
    textAlign:'right',
    // backgroundColor:'red'
  },

});
