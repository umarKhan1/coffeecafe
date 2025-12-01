import 'package:coffeecafe/core/constants/app_assets.dart';
import 'package:coffeecafe/features/product_detail/models/milk_type.dart';
import 'package:coffeecafe/features/product_detail/models/product_detail.dart';
import 'package:coffeecafe/features/product_detail/repositories/i_product_repository.dart';

class ProductRepository implements IProductRepository {
  const ProductRepository();

  static final Map<String, ProductDetail> _mock = {
    'cappuccino': ProductDetail(
      id: 'cappuccino',
      title: 'Cappuccino',
      subtitle: 'Drizzled with Caramel',
      description:
          'A single espresso shot poured into hot foamy milk, with the surface topped with mildly sweetened cocoa powder and drizzled with scrumptious caramel syrup for a balanced treat.',
      rating: 4.5,
      price: 249,
      image: AppAssets.cup,
      availableMilks: const [MilkType.oat, MilkType.soy, MilkType.almond],
    ),
    'chai_latte': ProductDetail(
      id: 'chai_latte',
      title: 'Chai Latte',
      subtitle: 'Spiced Comfort',
      description: 'A warming blend of black tea, aromatic spices, steamed milk, lightly sweetened for a cozy sip.',
      rating: 4.4,
      price: 85,
      image: AppAssets.chai,
      availableMilks: const [MilkType.oat, MilkType.soy, MilkType.almond],
    ),
    'matcha_latte': ProductDetail(
      id: 'matcha_latte',
      title: 'Matcha Latte',
      subtitle: 'Green Vitality',
      description: 'Creamy Japanese matcha whisked into silky milk delivering calm energy and delicate umami.',
      rating: 4.6,
      price: 22,
      image: AppAssets.matcha,
      availableMilks: const [MilkType.oat, MilkType.soy, MilkType.almond],
    ),
    'red_eye_coffee': ProductDetail(
      id: 'red_eye_coffee',
      title: 'Red Eye Coffee',
      subtitle: 'Extra Kick',
      description: 'Smooth drip coffee supercharged with a shot of espresso for bold mornings and late grinds.',
      rating: 4.3,
      price: 60,
      image: AppAssets.redEye,
      availableMilks: const [MilkType.oat, MilkType.soy],
    ),
    'merlot': ProductDetail(
      id: 'merlot',
      title: 'Merlot',
      subtitle: 'Velvety Red',
      description: 'Soft tannins and dark fruit notes make this Merlot an easy pairing for relaxed evenings.',
      rating: 4.7,
      price: 120,
      image: AppAssets.cup,
      availableMilks: const [],
    ),
    'chardonnay': ProductDetail(
      id: 'chardonnay',
      title: 'Chardonnay',
      subtitle: 'Golden Classic',
      description: 'Crisp citrus layered with subtle oak. A balanced white for sunny afternoons.',
      rating: 4.5,
      price: 140,
      image: AppAssets.cup,
      availableMilks: const [],
    ),
  };

  @override
  Future<ProductDetail> getProductById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return _mock[id] ?? _mock.values.first;
  }
}
