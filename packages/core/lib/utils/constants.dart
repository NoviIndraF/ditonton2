
import 'dart:io';

import 'package:flutter/services.dart';

const String BASE_IMAGE_URL = 'https://image.tmdb.org/t/p/w500';
const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
const BASE_URL = 'https://api.themoviedb.org/3';

const ADD_SUCCESS = 'Added to Watchlist';
const REMOVE_SUCCESS = 'Removed from Watchlist';


Future<SecurityContext> get globalContext async {
  final sslCert = await rootBundle.load('certificate/certificate.cer');
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
  return securityContext;
}

