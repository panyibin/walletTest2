import { AppRegistry } from 'react-native';

import WalletGenerator from './js/WalletGenerator';
import PinView from './js/pin';
import Wallet from './js/Wallet';
import WalletDetail from './js/WalletDetail';
import PayView from './js/pay';

AppRegistry.registerComponent('WalletGenerator', () => WalletGenerator);
AppRegistry.registerComponent('PinView', () => PinView);
AppRegistry.registerComponent('Wallet', () => Wallet);
AppRegistry.registerComponent('WalletDetail', () => WalletDetail);
AppRegistry.registerComponent('PayView', () => PayView);
