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
  TouchableOpacity,
  FlatList
} from 'react-native';

var walletManager = NativeModules.WalletManager;
var navigationHelper = NativeModules.NavigationHelper;

type Props = {};
export default class Wallet extends Component<Props> {

  constructor(props){
    super(props);
    this.state = {pinCode:"", pinCodeConfirm:""};
    // Alert.alert(props.data);
  }

async tapNewWallet() {
    navigationHelper.showWalletGeneratorViewControllerAnimated(true);
  }

  render() {
    return (
        <View style={styles.container}>
            <Text style={styles.welcome}>
                Wallets
            </Text>
            <View style={{backgroundColor:'red'}}>
                <Text style={styles.skyCoinBalance}>
                    {this.props.totalCoinBalance + ' SKY'}
                </Text>
                <Text style={styles.skyHourBalance}>
                    {this.props.totalHourBalance + ' Hours'}
                </Text>
            </View>
            <View style={{marginTop:50, backgroundColor:'green', height:300}}>
                <View style={{flexDirection:'row',marginTop:10,marginBottom:10}}>
                 <Text style={{marginLeft:10,width:100, backgroundColor:'transparent',fontSize:15}}>Wallet</Text>
                 <Text style={{marginLeft:200, backgroundColor:'transparent',fontSize:15}}>Balance</Text>
                </View>
                <View style={{height:0.5, backgroundColor:'grey'}} />
                <FlatList
                data={this.props.data}

                renderItem={({item})=>{
                    return (
                        <View>
                        <View style={{ flexDirection: 'row', marginBottom:10,marginTop:10 }}>
                        <View style={{marginLeft:10,width:100}}>
                        <Text style={{backgroundColor: 'transparent', fontSize: 15 }}>{item.walletName}</Text>
                        </View>
                        <View style={{marginLeft:200, width:100}}>
                        <Text style={{backgroundColor: 'yellow', fontSize: 15, textAlign:'left' }}>{item.balance}</Text>
                        </View>                                                        
                        </View>
                        <View 
                        style={{height:0.5, backgroundColor:'grey'}}
                        />
                        </View>
                    );
                }}

                keyExtractor = { item => item.walletId}

                >
                </FlatList>
            </View>
            <View style={{ flexDirection: 'row', justifyContent: 'center' }}>
                <TouchableOpacity style={styles.newWalletButton} onPress={this.tapNewWallet.bind(this)}>
                    <Text style={styles.createButtonText}>New Wallet</Text>
                </TouchableOpacity>
                <TouchableOpacity style={styles.loadWalletButton} onPress={this.tapNewWallet.bind(this)}>
                    <Text style={styles.createButtonText}>Load Wallet</Text>
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
  skyCoinBalance: {
    textAlign: 'center',
    fontSize:35,
    color: 'white',
    marginTop:50,
  },
  skyHourBalance: {
    textAlign: 'center',
    fontSize:17,
    color: 'white',
    marginTop:20,
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
  newWalletButton:{
    marginTop:100,
    marginRight:15,
    height:30,
    width:120,
    backgroundColor:'grey',
    alignItems:'center',
    borderRadius:15
  },
  loadWalletButton:{
    marginTop:100,
    marginLeft:15,
    height:30,
    width:120,
    backgroundColor:'grey',
    alignItems:'center',
    borderRadius:15
  },
  createButtonText:{
    textAlign:'center',
    fontSize:18,
    color:'black',
    marginTop:3.5
  }

});
