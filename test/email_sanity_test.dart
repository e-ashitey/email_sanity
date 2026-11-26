import 'package:email_sanity/email_sanity.dart';
import 'package:test/test.dart';

void main() {
  final validAddresses = <String>[
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
    'email@gmail.com',
    'email@googlemail.com',
    'email@yahoo.co.uk',
    'email@yahoo.co.jp',
    'email@yahoo.com.au',
    'email@yahoo.com.br',
    'email@yahoo.co.in',
    'email@ymail.com',
    'email@hotmail.com',
    'email@outlook.co.uk',
    'email@live.com',
    'email@msn.nl',
    'email@icloud.com',
    'email@me.com',
    'email@mac.com',
    'email@yandex.ru',
    'email@fastmail.fm',
    'User@Gmail.COM',
    '  email@gmail.com  ',
  ];

  final invalidAddresses = <String>[
    'invalid',
    'invalid@',
    'invalid @',
    'invalid@[555.666.777.888]',
    'invalid@[IPv6:123456]',
    'invalid@[127.0.0.1.]',
    'invalid@[127.0.0.1].',
    'invalid@[127.0.0.1]x',
    'Abc.example.com',
    'A@b@c@example.com',
    'a"b(c)d,e:f;g<h>i[j\\k]l@example.com',
    'just"not"right@example.com',
    'this is"not\\allowed@example.com',
    'this\\ still\\"not\\\\allowed@example.com',
    '! #\$%`|@invalid-characters-in-local.org',
    '(),:;`|@more-invalid-characters-in-local.org',
    '* .local-starts-with-dot@sld.com',
    '<>@[]`|@even-more-invalid-characters-in-local.org',
    '@missing-local.org',
    'IP-and-port@127.0.0.1:25',
    'another-invalid-ip@127.0.0.256',
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
    'No longer available.',
    'Moved.',
  ];

  final validInternational = <String>[
    '伊昭傑@郵件.商務',
    'राम@मोहन.ईन्फो',
    'юзер@екзампл.ком',
    'θσερ@εχαμπλε.ψομ',
  ];

  final specialUserMistakes = <String>[
    'email@gmail.co',
    'email@gmail.con',
    'email@gmail.clm',
    'email@gmail.coma',
    'email@gmail.comb',
    'email@gmail.come',
    'email@gmail.comj',
    'email@gmail.comn',
    'email@gmail.como',
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

  final lookalikeDomains = <String>[
    'user@gmail.com.attacker.com',
    'user@gmail.notreally.com',
    'user@me.company.com',
    'user@mac.example.com',
    'user@live.comedy.com',
    'user@hotmail.co',
    'user@outlook.co',
    '"Abc@def"@gmail.con',
  ];

  group('EmailSanity.validate', () {
    test('rejects invalidAddresses', () {
      for (final email in invalidAddresses) {
        expect(
          EmailSanity.validate(email, allowTopLevelDomains: true),
          isFalse,
          reason: 'E-mail: $email',
        );
      }
    });

    test('accepts validAddresses', () {
      for (final email in validAddresses) {
        expect(
          EmailSanity.validate(email, allowTopLevelDomains: true),
          isTrue,
          reason: 'E-mail: $email',
        );
      }
    });

    test('accepts validInternational when allowInternational is true', () {
      for (final email in validInternational) {
        expect(
          EmailSanity.validate(
            email,
            allowTopLevelDomains: true,
            allowInternational: true,
          ),
          isTrue,
          reason: 'E-mail: $email',
        );
      }
    });

    test('rejects specialUserMistakes', () {
      for (final email in specialUserMistakes) {
        expect(
          EmailSanity.validate(email, allowTopLevelDomains: true),
          isFalse,
          reason: 'E-mail: $email',
        );
      }
    });

    test('rejects lookalikeDomains', () {
      for (final email in lookalikeDomains) {
        expect(
          EmailSanity.validate(email),
          isFalse,
          reason: 'E-mail: $email',
        );
      }
    });

    test('uses production defaults for allowTopLevelDomains', () {
      expect(EmailSanity.validate('user@com'), isFalse);
    });
  });

  group('EmailSanity.validateWithDetails', () {
    test('returns requireEmail for empty and whitespace-only input', () {
      for (final email in ['', '   ', '\t']) {
        final result = EmailSanity.validateWithDetails(email);
        expect(result.isValid, isFalse, reason: 'E-mail: "$email"');
        expect(
          result.error,
          EmailValidationError.requireEmail,
          reason: 'E-mail: "$email"',
        );
        expect(
          result.errorMessage,
          EmailValidationError.requireEmail.message,
          reason: 'E-mail: "$email"',
        );
      }
    });

    test('returns missingAtSymbol when @ is absent', () {
      final result = EmailSanity.validateWithDetails('invalidemail.com');
      expect(result.isValid, isFalse);
      expect(result.error, EmailValidationError.missingAtSymbol);
      expect(
        result.errorMessage,
        EmailValidationError.missingAtSymbol.message,
      );
    });

    test('returns invalidDomain for each specialUserMistake', () {
      for (final email in specialUserMistakes) {
        final result = EmailSanity.validateWithDetails(
          email,
          allowTopLevelDomains: true,
        );
        expect(result.isValid, isFalse, reason: 'E-mail: $email');
        expect(
          result.error,
          EmailValidationError.invalidDomain,
          reason: 'E-mail: $email',
        );
        expect(
          result.errorMessage,
          EmailValidationError.invalidDomain.message,
          reason: 'E-mail: $email',
        );
      }
    });

    test('returns invalidDomain for lookalikeDomains', () {
      for (final email in lookalikeDomains) {
        final result = EmailSanity.validateWithDetails(email);
        expect(result.isValid, isFalse, reason: 'E-mail: $email');
        expect(
          result.error,
          EmailValidationError.invalidDomain,
          reason: 'E-mail: $email',
        );
      }
    });

    test('accepts validAddresses', () {
      for (final email in validAddresses) {
        expect(
          EmailSanity.validateWithDetails(
            email,
            allowTopLevelDomains: true,
          ).isValid,
          isTrue,
          reason: 'E-mail: $email',
        );
      }
    });

    test('accepts validInternational', () {
      for (final email in validInternational) {
        expect(
          EmailSanity.validateWithDetails(
            email,
            allowTopLevelDomains: true,
            allowInternational: true,
          ).isValid,
          isTrue,
          reason: 'E-mail: $email',
        );
      }
    });

    test('rejects invalidAddresses', () {
      for (final email in invalidAddresses) {
        expect(
          EmailSanity.validateWithDetails(
            email,
            allowTopLevelDomains: true,
          ).isValid,
          isFalse,
          reason: 'E-mail: $email',
        );
      }
    });

    test('exposes a message for every error code', () {
      for (final error in EmailValidationError.values) {
        expect(error.message, isNotEmpty, reason: error.name);
      }
    });
  });
}
