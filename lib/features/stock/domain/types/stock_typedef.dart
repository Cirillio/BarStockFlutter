import 'package:bar_stock/features/stock/domain/entities/category.dart';
import 'package:bar_stock/features/stock/domain/entities/product_item.dart';
import 'package:bar_stock/features/stock/domain/entities/product_list_item.dart';

typedef ProductList = List<ProductListItem>;
typedef AllProductListByCategory = Map<Category, List<ProductItem>>;
typedef ProductListByCategory = Map<Category, List<ProductListItem>>;
