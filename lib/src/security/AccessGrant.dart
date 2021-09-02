import 'package:cleanarch/locales.dart';
import 'package:cleanarch/validations.dart';

class AccessGrant
    implements IValidatable
{
  static const AccessGrant invalid = AccessGrant('',0,'','');

  /// Type of the access token.
  final String type;
  /// An integer representing the TTL of the access token.
  final int expiresIn;
  /// The access token itself.
  final String accessToken;
  /// A refresh token that can be used to acquire a new access token
  /// when the original expires.
  final String refreshToken;

  final IIntl? _intl;

  const AccessGrant(this.type, this.expiresIn, this.accessToken, this.refreshToken, [this._intl]);

  AccessGrant.fromJson( Map<String, dynamic> json, [this._intl])
    : type = json['type']
    , expiresIn = json['expiresIn']
    , accessToken = json['accessToken']
    , refreshToken = json['refreshToken']
    ;

  Map<String, dynamic> toJson() => {
    'type': type,
    'expiresIn': expiresIn,
    'accessToken': accessToken,
    'refreshToken': refreshToken
  };

  @override
  bool get isValid => validate().isEmpty;

  @override
  List<ValidationResult> validate() {
    var validations = <ValidationResult>[];
    var result = validateType();
    if( result.hasError ) {
      validations.add(result);
    }
    result = validateExpiresIn();
    if( result.hasError ) {
      validations.add(result);
    }
    result = validateAccessToken();
    if( result.hasError ) {
      validations.add(result);
    }
    result = validateRefreshToken();
    if( result.hasError ) {
      validations.add(result);
    }
    return validations;
  }

  /// Validates if the attribute [type] is not empty. Else, the method gets the
  /// message error `accessTokenTypeIsEmptyOrNull` from [_intl] if defined.
  ValidationResult validateType() {
    final memberName = 'type';
    if (type.isEmpty) {
      var message = 'Access token type is empty or null';
      if( _intl != null ) {
        message = _intl!['accessTokenTypeIsEmptyOrNull'];
      }
      return ValidationResult(memberName, message );
    }
    return ValidationResult.success();
  }

  /// Validates the attribute [expiresIn] is zero or negative. Else, the method
  /// gets the message error `accessTokenExpirationIsZeroOrNegative` from [_intl] if defined.
  ValidationResult validateExpiresIn() {
    final memberName = 'expiresIn';
    if (expiresIn <= 0) {
      var message = 'Access token expiration is zero or negative';
      if( _intl != null ) {
        message = _intl!['accessTokenExpirationIsZeroOrNegative'];
      }
      return ValidationResult(memberName, message );
    }
    return ValidationResult.success();
  }

  /// Validates the attribute [accessToken] is empty or null. Else, the method
  /// gets the message error `accessTokenIsEmptyOrNull` from [_intl] if defined.
  ValidationResult validateAccessToken() {
    final memberName = 'accessToken';
    if (expiresIn <= 0) {
      var message = 'Access token is empty or null';
      if( _intl != null ) {
        message = _intl!['accessTokenIsEmptyOrNull'];
      }
      return ValidationResult(memberName, message );
    }
    return ValidationResult.success();
  }

  /// Validates the attribute [refreshToken] is empty or null. Else, the method
  /// gets the message error `refreshTokenIsEmptyOrNull` from [_intl] if defined.
  ValidationResult validateRefreshToken(){
    final memberName = 'refreshToken';
    if (expiresIn <= 0) {
      var message = 'Refresh token is empty or null';
      if( _intl != null ) {
        message = _intl!['refreshTokenIsEmptyOrNull'];
      }
      return ValidationResult(memberName, message );
    }
    return ValidationResult.success();
  }
}