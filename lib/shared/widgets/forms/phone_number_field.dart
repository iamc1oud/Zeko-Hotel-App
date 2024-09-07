import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show FilteringTextInputFormatter, rootBundle;
import 'package:flutter_svg/svg.dart';
import 'package:zeko_hotel_crm/assets.dart';
import 'package:zeko_hotel_crm/main.dart';
import 'package:zeko_hotel_crm/utils/extensions/extension.dart';
import 'package:zeko_hotel_crm/utils/extensions/extensions.dart';

// Entity
class Country {
  final String name;
  final String flag;
  final String number;

  Country({required this.name, required this.flag, required this.number});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'],
      flag: json['flag'],
      number: json['number'],
    );
  }
}

class PhoneNumberField extends StatefulWidget {
  final Function onChanged;

  const PhoneNumberField({super.key, required this.onChanged});

  @override
  _PhoneNumberFieldState createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  List<Country> _countries = [];
  Country? _selectedCountry;

  @override
  void initState() {
    super.initState();
    _loadCountryData();
  }

  Future<void> _loadCountryData() async {
    final String response =
        await rootBundle.loadString(PlatformAssets.phoneNumberJson);
    final List<dynamic> data = json.decode(response);
    setState(() {
      _countries = data.map((json) => Country.fromJson(json)).toList();
      _selectedCountry = _countries.first; // default to the first country
    });
  }

  @override
  Widget build(BuildContext context) {
    return _selectedCountry == null
        ? const CircularProgressIndicator()
        : TextFormField(
            validator: (v) {
              if (v!.isEmpty) {
                return 'Required';
              }
              return null;
            },
            onChanged: (v) {
              widget.onChanged.call('${_selectedCountry!.number}$v');
            },
            decoration: InputDecoration(
              hintText: Strings!.phoneNumber,
              floatingLabelAlignment: FloatingLabelAlignment.start,
              prefixIcon: DropdownButton<Country>(
                borderRadius: Corners.lgBorder,
                menuMaxHeight: AppMediaQuery.size.height * 0.5,
                value: _selectedCountry,
                onChanged: (Country? newValue) {
                  setState(() {
                    _selectedCountry = newValue!;
                  });
                },
                underline: SizedBox(),
                padding: Paddings.horizontalPadding,
                items: _countries
                    .map<DropdownMenuItem<Country>>((Country country) {
                  return DropdownMenuItem<Country>(
                    value: country,
                    child: Row(
                      children: [
                        SvgPicture.network(
                          country.flag,
                          width: 20,
                        ),
                        Spacing.wlg,
                        Text(country.number)
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: const TextInputType.numberWithOptions(
                decimal: false, signed: false),
          ).addLabel(Strings!.phoneNumber);
  }
}
