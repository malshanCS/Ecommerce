<?php
    shuffle($product_shuffle);
?>

<section id="hot-items">
    <div class="container py-5">
        <h4 class="font-rubik font-size-20">Hot Items</h4>
        <hr>
        <!-- owl carousel -->
        <div class="owl-carousel owl-theme">
            <?php foreach ($product_shuffle as $item) { ?>
            <div class="item py-2">
                <div class="product font-raleway">

                    <a href="#"><img src="<?php echo $item['image']??"./assets/products/iphone13pro.jpg"; ?>" alt="product1" class="img-fluid"></a>
                    <div class="text-center">
                        <h6><?php echo $item['title']??"Unknown"; ?></h6>

                        <div class="rating font-size-12">
                            <span><i class="fas fa-star text-warning"></i></span>
                            <span><i class="fas fa-star text-warning"></i></span>
                            <span><i class="fas fa-star text-warning"></i></span>
                            <span><i class="fas fa-star text-warning"></i></span>
                            <span><i class="far fa-star text-warning"></i></span>
                        </div>
                    </div>

                    <div class="price py-2">
                        <span><?php echo $item['base']??"-"; ?></span>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-warning font-size-12">Add to cart</button>
                    </div>

                </div>
            </div>
            <?php } ?>
        </div>

    </div>
</section>