import '../models/fuel_info.dart';
import '../models/trip_info.dart';

class DemoData {
  static const trips = [
    TripInfo('Majestic', 'Electronic City Phase 1', '18.4 km', 'Today', '8:20 AM'),
    TripInfo(
      'Jayanagar 4th Block',
      'Bengaluru City Railway Station',
      '9.2 km',
      'Today',
      '7:05 AM',
    ),
    TripInfo('Koramangala', 'Whitefield', '22.8 km', 'Yesterday', '4:10 PM'),
    TripInfo('Indiranagar', 'Yeshwanthpur', '14.1 km', 'Yesterday', '11:35 AM'),
    TripInfo('Hebbal', 'Manyata Tech Park', '6.7 km', 'Nov 23', '3:15 PM'),
    TripInfo('Rajajinagar', 'Kempegowda Airport', '34.6 km', 'Nov 23', '9:40 AM'),
    TripInfo('BTM Layout', 'Bannerghatta Road', '11.3 km', 'Nov 22', '2:20 PM'),
    TripInfo('Marathahalli', 'MG Road', '16.2 km', 'Nov 22', '10:10 AM'),
    TripInfo('Peenya', 'Electronic City', '29.8 km', 'Nov 21', '7:30 AM'),
    TripInfo('Basavanagudi', 'Majestic', '5.6 km', 'Nov 20', '5:05 PM'),
  ];

  static const fuelEntries = [
    FuelInfo('HP Fuel Point', 'Today · 8:10 AM', '32 L', '₹3,238'),
    FuelInfo('Bharat Petroleum', 'Nov 23 · 9:15 AM', '28 L', '₹2,856'),
    FuelInfo('IndianOil Express', 'Nov 21 · 7:40 AM', '35 L', '₹3,570'),
    FuelInfo('HP Fuel Point', 'Nov 19 · 5:05 PM', '24 L', '₹2,448'),
  ];
}
