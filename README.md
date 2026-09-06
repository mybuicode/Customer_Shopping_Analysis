# Customer_Shopping_Analysis
Project Background

This project analyzes customer shopping behavior using the Customer Shopping Trends dataset sourced from Kaggle. The dataset contains 3,900 customer purchase records covering customer demographics, product preferences, purchase amounts, seasonal behavior, geographic information, subscription status, discounts, and customer review ratings.

From the perspective of a Data Analyst supporting an e-commerce and retail business, the objective is to transform transactional and customer-level data into actionable insights that can support:
- Customer segmentation and engagement
- Product and inventory planning
- Regional assortment optimization
- Promotional and subscription strategy
- Customer experience improvement

The analysis focuses on four key business questions:
- Who are our customers and how do they behave?
- Which products and seasonal patterns drive demand?
- How does customer behavior vary across locations?
- Are discounts and subscriptions associated with higher customer spending?

Insights and recommendations are provided across the following key areas:
- Category 1: Demographics & Customer Segmentation
- Category 2: Seasonal & Regional Product Demand
- Category 3: Geographic Performance & Store Location Benchmarks
- Category 4: Promotional Effectiveness & Customer Loyalty Programs

The SQL queries used to inspect and clean the data for this analysis can be found here [GitHub Repository Link].<br>
Targeted SQL queries regarding various business questions can be found here [GitHub Queries Link].<br>
An interactive Tableau dashboard used to report and explore sales trends can be found here [Tableau Dashboard Link].
<hr>
###Data Structure & Initial Checks
The analysis uses a single table: shopping_trends_updated
The dataset contains 3,900 records and 3,900 unique Customer IDs.
<hr>
Executive Summary
Overview of Findings

An analysis of 3,900 transaction records reveals that while our total customer base is predominantly Male (68%) and driven by core Clothing sales, current promotional incentives (Discounts) and Subscription programs are failing to expand transaction sizes (AOV sits flat at ~$59-$60 across all groups). High-performing revenue states like Montana ($5,784 total revenue) are driven almost entirely by order volume rather than high cart value (ranking 6th in AOV), whereas top customer experience hubs like Michigan and New Jersey lead in CSAT ratings. To unlock growth, the business must shift from flat promotional discounting to localized inventory allocation and tiered loyalty thresholds.

Insights Deep Dive
Category 1: Demographics & Customer Segmentation
- Male dominance in customer base: Out of 3,900 distinct customers, Male shoppers represent 68% of the customer base, while Female shoppers account for 32%, indicating a significant gender skew in current market reach.
- Clothing as the primary revenue generator: Among all major product categories, Clothing generates the highest total revenue, establishing itself as the core anchor category driving baseline sales across both gender segments.
- Purchase frequency does not drive higher transaction value: Customers with more than 10 previous purchases average $59 per transaction, whereas customers with 10 or fewer previous purchases average $60. High purchase frequency is not associated with higher Basket Size or AOV.
- Uniform spending across age & gender groups: Spend per transaction remains tightly bounded between $50 and $70 regardless of customer age brackets or gender, indicating a highly standard price point distribution across the catalog.

Category 2: Seasonal & Regional Product Demand
- Spring demand peaks in Sweaters & Shorts: Ranked ranking analysis reveals Spring purchases are led by Sweaters and Shorts, with top color preferences leaning toward Olive, Gray, and Teal.
- Summer shifts to Pants, Jewelry, & Dresses: Summer sales are dominated by Pants, followed by Jewelry and Dresses, with Silver, Teal, and Blue ranking as the top 3 preferred colors.
- Fall preferences highlight Jackets & Accessories: Fall purchasing pivots heavily toward Jackets, Hats, and Handbags, with strong color affinity for Magenta, Yellow, and Olive.
- Winter demand surges for Sunglasses & Pants: Winter items are led unexpectedly by Sunglasses, followed by Pants and Shirts, with Green, Yellow, and Pink leading color selections.

Category 3: Geographic Performance & Store Location Benchmarks
- Montana leads in Total Revenue via Volume: Montana generated the highest total revenue ($5,784) across all 50 states, yet its average transaction value ($60) ranks only 6th overall, confirming revenue is driven by transaction volume rather than premium order sizes.
- Top-performing locations in Customer Experience: Michigan and New Jersey achieved the highest average customer review ratings (Review_Rating), making them operational benchmarks for customer service and product satisfaction practices.
- Significant variation in item preferences by location: Item ranking queries partitioned by location show that top-purchased items vary significantly by state (e.g., outerwear dominates northern regions while accessories lead in others), proving that localized demand exists.
- Regional revenue fragmentation: No single state contributes more than 3-4% of total revenue, highlighting a highly decentralized physical footprint that requires tailored distribution strategies

Category 4: Promotional Effectiveness & Customer Loyalty Programs
- Subscriptions fail to lift order values: Subscribed customers average $59.37 per purchase compared to $59.86 for non-subscribed customers, showing zero positive lift in AOV from subscription enrollment.
- Non-subscribed customers form the vast majority: Unsubscribed customers significantly outnumber subscribed customers in total volume, representing an under-leveraged audience for retention marketing.
- Discounts slightly reduce average spend: Transactions with a Discount Applied averaged a slightly lower purchase value ($58.70) than full-price transactions ($60.15), indicating that discounts are currently eroding margin without driving basket expansion.
- Promotional codes are underutilized for upselling: Current promo structures apply indiscriminately across low and high values rather than encouraging customers to cross a Minimum Order Quantity (MOQ) or Spend Threshold.
<hr>
Recommendations<br>
Based on the insights above, the business should consider the following:
- Adopt localized inventory planning. Product preferences vary across locations, so inventory allocation should reflect regional demand rather than relying on a uniform assortment.
- Prioritize the Clothing category. Since Clothing generates the highest revenue, the business should maintain strong product availability and assortment within this category.
- Incorporate seasonality into inventory planning. Product and color preferences vary by season, providing an opportunity to optimize seasonal product assortments.
- Evaluate subscription performance beyond transaction value. Since subscribers do not appear to spend more per transaction, the business should assess purchase frequency, retention and customer lifetime value.
- Move toward targeted promotional strategies. Since discounts do not appear to increase average purchase value, promotions should be evaluated by product category, customer segment and purchase frequency rather than applied broadly.
