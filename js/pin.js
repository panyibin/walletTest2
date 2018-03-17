/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  NativeModules,
  Platform,
  StyleSheet,
  Text,
  View,
  TextInput,
  Button,
  Alert,
  TouchableOpacity
} from 'react-native';

var walletManager = NativeModules.WalletManager;
var navigationHelper = NativeModules.NavigationHelper;

type Props = {};
export default class PinView extends Component<Props> {

  constructor(props){
    super(props);
    this.state = {pinCode:"", pinCodeConfirm:""};
  }

async tapCreate() {
      var pinCode = this.state.pinCode;
      var pinCodeConfirm = this.state.pinCodeConfirm;
      if(pinCode.length != 6) {
          Alert.alert("pin code must be 6 digits");
      } else if (pinCode != pinCodeConfirm) {
          Alert.alert("the pin codes you input aren't the same");
      } else {
          console.log('create wallet');
          var success = await walletManager.createNewWallet(this.props.walletName, this.props.seed, pinCode);

          if(success) {
              // Alert.alert('create wallet success');
              navigationHelper.popToRootViewControllerAnimated(true);
          } else {
              Alert.alert('fail to create wallet');
              // navigationHelper.popToRootViewControllerAnimated(true);
          }
      }
  }

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Great, now create a pin
        </Text>
        <Text style={styles.instructions}>
       This PIN # will be used to open the wallet. Don't forget your pin. If you do, you may lose access to your mobile wallet..
        </Text>
        <Text style={styles.pinCodeTitle}>
        pin code (must be 6 digits)
        </Text>
        <TextInput 
        style={styles.textInputPinCode} 
        secureTextEntry={true}
        onChangeText={
            (text)=>{
                this.setState({pinCode:text});
            }
        }
        />
        <Text style={styles.pinCodeTitleConfirm}>
        confirm your pin code
        </Text>
            <TextInput
                style={styles.textInputPinCode}
                secureTextEntry={true}
                onChangeText={
                    (text) => {
                        this.setState({ pinCodeConfirm: text });
                    }
                }
            ></TextInput>
        <View style={{alignItems:'center'}}>
        <TouchableOpacity style={styles.createButton} onPress={this.tapCreate.bind(this)}>
        <Text style={styles.createButtonText}>Create Wallet</Text>
        </TouchableOpacity>
        </View>
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
  pinCodeTitle: {
    textAlign: 'left',
    fontSize:15,
    color: 'white',
    marginTop:50,
    marginLeft:35
  },
  pinCodeTitleConfirm: {
    textAlign: 'left',
    fontSize:15,
    color: 'white',
    marginTop:10,
    marginLeft:35
  },
  subTitleSeed: {
    textAlign: 'left',
    fontSize:15,
    color: 'white',
    marginTop:50,
    marginLeft:35
  },
  textInputPinCode: {
    fontSize:15,
    backgroundColor:'white',
    marginLeft:35,
    marginRight:35,
    marginTop:10,
    height:23,
    borderRadius:5
  },
  textInputSeed: {
    fontSize:15,
    backgroundColor:'white',
    marginLeft:35,
    marginRight:35,
    marginTop:10,
    height:45,
    borderRadius:5,
    // textAlign:'left'
  },
  seedGenerateButton: {
    // backgroundColor:'green',
    marginLeft:35,
    marginRight:35,
    marginTop:10,
  },
  seedGenerateButtonText: {
    color:'white',
    // marginRight:35,
    textAlign:'right',
    // backgroundColor:'red'
  },
  createButton:{
    marginTop:250,
    height:30,
    width:180,
    backgroundColor:'black',
    alignItems:'center',
    borderRadius:15
  },
  createButtonText:{
    textAlign:'center',
    fontSize:18,
    color:'white',
    marginTop:3.5
  }

});
