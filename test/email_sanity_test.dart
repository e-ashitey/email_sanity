import 'package:email_sanity/src/email_sanity.dart';
import 'package:email_sanity/src/model/validation_result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final List<String> validAddresses = [
    'fredrik@dualog.com',
    '"Abc\\@def"@example.com',
    '"Fred Bloggs"@example.com',
    '"Joe\\\\Blow"@example.com',
    '"Abc@def"@example.com',
    'customer/department=shipping@example.com',
    '\$A12345@example.com',
    '!def!xyz%abc@example.com',
    '_somename@example.com',
    'valid.ipv4.addr@[123.1.72.10]',
    'valid.ipv6.addr@[IPv6:0::1]',
    'valid.ipv6.addr@[IPv6:2607:f0d0:1002:51::4]',
    'valid.ipv6.addr@[IPv6:fe80::230:48ff:fe33:bc33]',
    'valid.ipv6.addr@[IPv6:fe80:0000:0000:0000:0202:b3ff:fe1e:8329]',
    'valid.ipv6v4.addr@[IPv6:aaaa:aaaa:aaaa:aaaa:aaaa:aaaa:127.0.0.1]',

    // examples from wikipedia
    'niceandsimple@example.com',
    'very.common@example.com',
    'a.little.lengthy.but.fine@dept.example.com',
    'disposable.style.email.with+symbol@example.com',
    'user@[IPv6:2001:db8:1ff::a0b:dbd0]',
    '"much.more unusual"@example.com',
    '"very.unusual.@.unusual.com"@example.com',
    '"very.(),:;<>[]\\".VERY.\\"very@\\\\ \\"very\\".unusual"@strange.example.com',
    "!#\$%&'*+-/=?^_`{}|~@example.org",
    "\"()<>[]:,;@\\\\\\\"!#\$%&'*+-/=?^_`{}| ~.a\"@example.org",
    '" "@example.org',

    // examples from https://github.com/Sembiance/email-validator
    '"\\e\\s\\c\\a\\p\\e\\d"@sld.com',
    '"back\\slash"@sld.com',
    '"escaped\\"quote"@sld.com',
    '"quoted"@sld.com',
    '"quoted-at-sign@sld.org"@sld.com',
    "&'*+-./=?^_{}~@other-valid-characters-in-local.net",
    '01234567890@numbers-in-local.net',
    'a@single-character-in-local.org',
    'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ@letters-in-local.org',
    'backticksarelegit@test.com',
    'bracketed-IP-instead-of-domain@[127.0.0.1]',
    'country-code-tld@sld.rw',
    'country-code-tld@sld.uk',
    'letters-in-sld@123.com',
    'local@dash-in-sld.com',
    'local@sld.newTLD',
    'local@sub.domains.com',
    'mixed-1234-in-{+^}-local@sld.net',
    'one-character-third-level@a.example.com',
    'one-letter-sld@x.org',
    'punycode-numbers-in-tld@sld.xn--3e0b707e',
    'single-character-in-sld@x.org',
    'the-character-limit@for-each-part.of-the-domain.is-sixty-three-characters.this-is-exactly-sixty-three-characters-so-it-is-valid-blah-blah.com',
    'the-total-length@of-an-entire-address.cannot-be-longer-than-two-hundred-and-fifty-four-characters.and-this-address-is-254-characters-exactly.so-it-should-be-valid.and-im-going-to-add-some-more-words-here.to-increase-the-length-blah-blah-blah-blah-bla.org',
    'uncommon-tld@sld.mobi',
    'uncommon-tld@sld.museum',
    'uncommon-tld@sld.travel',

    // examples from providers
    'email@gmail.com',
    'email@yahoo.co.uk',
  ];

  final List<String> invalidAddresses = [
    'invalid',
    'invalid@',
    'invalid@',
    'invalid @',
    'invalid@[555.666.777.888]',
    'invalid@[IPv6:123456]',
    'invalid@[127.0.0.1.]',
    'invalid@[127.0.0.1].',
    'invalid@[127.0.0.1]x',

    // examples from wikipedia
    'Abc.example.com',
    'A@b@c@example.com',
    'a"b(c)d,e:f;g<h>i[j\\k]l@example.com',
    'just"not"right@example.com',
    'this is"not\\allowed@example.com',
    'this\\ still\\"not\\\\allowed@example.com',

    // examples from https://github.com/Sembiance/email-validator
    '! #\$%`|@invalid-characters-in-local.org',
    '(),:;`|@more-invalid-characters-in-local.org',
    '* .local-starts-with-dot@sld.com',
    '<>@[]`|@even-more-invalid-characters-in-local.org',
    '@missing-local.org',
    'IP-and-port@127.0.0.1:25',
    'another-invalid-ip@127.0.0.256',
    'invalid',
    'invalid-characters-in-sld@! "#\$%(),/;<>_[]`|.org',
    'invalid-ip@127.0.0.1.26',
    'local-ends-with-dot.@sld.com',
    'missing-at-sign.net',
    'missing-sld@.com',
    'missing-tld@sld.',
    'sld-ends-with-dash@sld-.com',
    'sld-starts-with-dashsh@-sld.com',
    'the-character-limit@for-each-part.of-the-domain.is-sixty-three-characters.this-is-exactly-sixty-four-characters-so-it-is-invalid-blah-blah.com',
    'the-local-part-is-invalid-if-it-is-longer-than-sixty-four-characters@sld.net',
    'the-total-length@of-an-entire-address.cannot-be-longer-than-two-hundred-and-fifty-four-characters.and-this-address-is-255-characters-exactly.so-it-should-be-invalid.and-im-going-to-add-some-more-words-here.to-increase-the-lenght-blah-blah-blah-blah-bl.org',
    'two..consecutive-dots@sld.com',
    'unbracketed-IP@127.0.0.1',
    'onelettertld@gmail.c',

    // examples of real (invalid) input from real users.
    'No longer available.',
    'Moved.',
  ];

  final List<String> validInternational = [
    '伊昭傑@郵件.商務', // Chinese
    'राम@मोहन.ईन्फो', // Hindi
    'юзер@екзампл.ком', // Ukranian
    'θσερ@εχαμπλε.ψομ', // Greek
  ];

  // examples of real (invalid) input from real users.
  final List<String> specialUserMistakes = [
    // Gmail
    'email@gmail.co',
    'email@gmail.con',
    'email@gmail.clm',
    'email@gmail.coma',
    'email@gmail.comb',
    'email@gmail.come',
    'email@gmail.comj',
    'email@gmail.comn',
    'email@gmail.como',

    // Yahoo
    'email@yahoo.co',
    'email@yahoo.con',
    'email@yahoo.clm',
    'email@yahoo.coma',
    'email@yahoo.comb',
    'email@yahoo.come',
    'email@yahoo.comj',
    'email@yahoo.comn',
    'email@yahoo.como',
    'email@yahoo.co.uka',
    'email@yahoo.com.uk',
  ];

  group("Email Validation Test (EmailSanity.validate)", () {
    test('Validate invalidAddresses are invalid emails', () {
      for (var actual in invalidAddresses) {
        expect(EmailSanity.validate(actual, true), equals(false),
            reason: 'E-mail: $actual');
      }
    });

    test('Validate validAddresses are valid emails', () {
      for (var actual in validAddresses) {
        expect(EmailSanity.validate(actual, true), equals(true),
            reason: 'E-mail: $actual');
      }
    });

    test('Validate validInternational are valid emails', () {
      for (var actual in validInternational) {
        expect(EmailSanity.validate(actual, true, true), equals(true),
            reason: 'E-mail: $actual');
      }
    });

    test('Validate specialUserMistakes are invalid emails', () {
      for (var actual in specialUserMistakes) {
        expect(EmailSanity.validate(actual, true), equals(false),
            reason: 'E-mail: $actual');
      }
    });
  });
  group("Email Validation Test With Details (EmailSanity.validateWithDetails)",
      () {
    test('Should return missingAtSymbol error when email lacks "@"', () {
      // Arrange
      const email = "invalidemail.com";

      // Act
      final result = EmailSanity.validateWithDetails(email);

      // Assert
      expect(result.isValid, false);
      expect(result.error, EmailValidationError.missingAtSymbol);
      expect(result.errorMessage, EmailValidationError.missingAtSymbol.message);
    });

    test('Validate inValidAddresses are invalid emails', () {
      for (var actual in invalidAddresses) {
        expect(EmailSanity.validateWithDetails(actual, true).isValid,
            equals(false));
      }
    });

    test('Validate validAddresses are valid emails', () {
      for (var actual in validAddresses) {
        expect(
            EmailSanity.validateWithDetails(actual, true).isValid, equals(true),
            reason: 'E-mail: $actual');
      }
    });

    test('Validate validInternational are valid emails', () {
      for (var actual in validInternational) {
        expect(EmailSanity.validateWithDetails(actual, true, true).isValid,
            equals(true),
            reason: 'E-mail: $actual');
      }
    });

    test('Validate specialUserMistakes are invalid emails', () {
      for (var actual in specialUserMistakes) {
        final san = EmailSanity.validateWithDetails("email@gmail.cos", true);

        expect(san.error, equals(EmailValidationError.invalidDomain),
            reason: 'E-mail: $actual');
        expect(san.errorMessage,
            equals(EmailValidationError.invalidDomain.message),
            reason: 'E-mail: $actual');
      }
    });
  });
}
