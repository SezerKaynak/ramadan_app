import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramadan_app/app/view/location/cubit/location_cubit.dart';
import 'package:ramadan_app/app/view/location/view/widgets/custom_dropdown_button.dart';
import 'package:ramadan_app/core/extensions/context_extension.dart';

class LocationSelect extends StatefulWidget {
  const LocationSelect({super.key});

  @override
  State<LocationSelect> createState() => _LocationSelectState();
}

class _LocationSelectState extends State<LocationSelect> {
  LocationCubit get _cubit => context.read<LocationCubit>();
  @override
  void initState() {
    _cubit.fetchCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        if (state is LocationLoaded || state is LocationSelectedState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Country",
                    style: context.textTheme.titleLarge,
                  ),
                  SizedBox(
                    width: context.dynamicWidth(0.35),
                    child: CustomDropdownButton<String>(
                      appSettings: true,
                      hint: "Select Country",
                      value: _cubit.selectedCountry,
                      items: _cubit.countryList.map((country) {
                        return DropdownMenuItem<String>(
                          value: country.name,
                          child: Text(country.name ?? ''),
                        );
                      }).toList(),
                      onChanged: (country) {
                        _cubit.selectCountry(country: country ?? '');
                        _cubit.fetchStates(country: country ?? '');
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "State",
                    style: context.textTheme.titleLarge,
                  ),
                  SizedBox(
                    width: context.dynamicWidth(0.35),
                    child: CustomDropdownButton<String>(
                      appSettings: true,
                      hint: "Select State",
                      value: _cubit.selectedState,
                      items: _cubit.stateList.map((state) {
                        return DropdownMenuItem<String>(
                          value: state,
                          child: Text(state),
                        );
                      }).toList(),
                      onChanged: (state) {
                        _cubit.selectState(state: state ?? '');
                        _cubit.fetchCities(
                          country: _cubit.selectedCountry ?? '',
                          state: state ?? '',
                        );
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "City",
                    style: context.textTheme.titleLarge,
                  ),
                  SizedBox(
                    width: context.dynamicWidth(0.35),
                    child: CustomDropdownButton<String>(
                      appSettings: true,
                      hint: "Select City",
                      value: _cubit.selectedCity,
                      items: _cubit.cityList.map((city) {
                        return DropdownMenuItem<String>(
                          value: city,
                          child: Text(city),
                        );
                      }).toList(),
                      onChanged: (city) {
                        _cubit.selectCity(city: city ?? '');
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
