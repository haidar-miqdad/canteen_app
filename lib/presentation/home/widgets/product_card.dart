part of '../pages/home_page.dart';

class ProductCard extends StatelessWidget {

  final Product product;
  final VoidCallback onPressed;

  const ProductCard({
    super.key, required this.product, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 9,
              offset: const Offset(0, 5),
            )
          ]
      ),
      height: 250,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SpaceHeight(20),
            Center(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    height: 90,
                    width: 90,
                    fit: BoxFit.fitWidth,
                    imageUrl: '${Variables.imageBaseUrl}${product.image}',
                    placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.food_bank_outlined,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ),
            const SpaceHeight(16.0),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SpaceHeight(5.0),
            Text(
              product.category,
              style: const TextStyle(
                color: AppColors.grey,
                fontSize: 14,
              ),
            ),
            const SpaceHeight(25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    product.price.currencyFormatRp,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: AppColors.primary,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
