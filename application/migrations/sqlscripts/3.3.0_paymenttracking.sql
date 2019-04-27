-- This is to cleanup any orphaned tax migration tables

RENAME TABLE `ospos_sales_payments` TO `ospos_sales_payments_backup`;

CREATE TABLE `ospos_sales_payments` (
  `payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `sale_id` int(10) NOT NULL,
  `payment_type` varchar(40) NOT NULL,
  `payment_amount` decimal(15,2) NOT NULL,
  `payment_user` int(11) NOT NULL DEFAULT 0,
  `payment_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reference_code` varchar(40) NOT NULL DEFAULT '',
  PRIMARY KEY (`payment_id`),
  KEY `paymnt_sale` (`sale_id`, `payment_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `ospos_sales_payments` (`sale_id`, `payment_type`, `payment_amount`)
SELECT `sale_id`, `payment_type`, `payment_amount` FROM `ospos_sales_payments_backup`;

DROP TABLE IF EXISTS `ospos_sales_payments_backup`;

CREATE TABLE `ospos_sales_stats` (
  `sale_id` int(10) NOT NULL,
  `prediscount_subtotal` decimal(15,2) NOT NULL,
  `subtotal` decimal(15,2) NOT NULL,
  `sales_total` decimal(15,2) NOT NULL,
  `total_discount` decimal(15,2) NOT NULL,
  `item_count` decimal(15,0) NOT NULL,
  `total_units` decimal(15,0) NOT NULL,
  `tax_total` decimal(15,2) NOT NULL,
  `payment_received` decimal(15,2) NOT NULL,
  `cash_refund` decimal(15,2) NOT NULL,
  `balance_due` decimal(15,2) NOT NULL,
  `after_sale_payments` decimal(15,2) NOT NULL,
  `net_due` decimal(15,2) NOT NULL,
  PRIMARY KEY (`sale_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

