import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVuZWhxY291cmlqYWplb2dsYWx5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ0Nzk5NDAsImV4cCI6MjA3MDA1NTk0MH0.FuWeT5bZ4jeiV2P6B7TF_OiNiRFyUD2tA4Olmnho4jI',
    url: 'https://unehqcourijajeoglaly.supabase.co',
  );
  runApp(const BarStockApp());
}
