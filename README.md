# Data-Driven-Businesses-with-SQL-Tableau - Project Overview:

* **Eniac**, a (fictional) company from Spain which sells Apple products, is exploring an expansion to the Brazilian market.
* **Eniac** lacks the knowledge of such a market, hence it needs another company with experience in dealing with providers, package delivery service, etc.
* **Magist** is a Brazilian Software as a Service company that offers a centralized order management system to connect small and medium-sized stores with the biggest Brazilian marketplaces.
* **Eniac** sells through its own e-commerce store in Europe, with its own site and direct providers for all the steps of the supply chain. In Brazil, however, Eniac is considering signing a 3-year contract with Magist and operating through external marketplaces as an intermediate step, while it tests the market, creates brand awareness, and explores the option of opening its own Brazilian marketplace.

There are two main concerns regarding the expansion of Eniac to the Brazilian market:

1. **Eniac’s catalog is 100% tech products, and heavily based on Apple-compatible accessories**. It is not clear that the marketplaces Magist works with are a good place for these high-end tech products.

1. Among Eniac’s efforts to have happy customers, fast deliveries are key. The delivery fees resulting from Magist’s deal with the public Post Office might be cheap, but at what cost? **Are deliveries fast enough?**

### Task and Scope:

The main purpose of the presentation is to recommend whether or not to sign the deal with Magist.

**Eniac:**
* online marketplace for Apple-compatible accessories
* competitive prices
* friendly and professional tech support and consultation

**Magist:**
* Service company
* Offers a centralized order management system
* has contracts with the Post Office ⇒ cheap fees + less bureaucracy 


### Code and resources used:

**MySQL:** MySQL Workbench, version 8.0.32

**Tableau:** Public, version 2022.2

**Data** Obtained from WBS coding school


### Analysis:

**Eniac KPIs:**

* Revenue: €40m
* Avg monthly revenue: €1.01m
* Avg order price: €710
* Avg item price: €540

**Magist:**

* Magist eCommerce platform is dominated by low-value orders and high concentration of orders on a few sellers
* Monthly tech revenue of sellers on Magist rarely over 300 €/m

![Screenshot 2023-01-25 at 13 23 44](https://user-images.githubusercontent.com/99658869/214562502-cd3bd190-8300-4d41-bfe6-5d3d3eafd8c3.png)

![Screenshot 2023-01-25 at 13 26 33](https://user-images.githubusercontent.com/99658869/214563085-7d96b3e6-545f-441d-857a-3f85ee84f4d6.png)

* Expected order delivering times according to Magists-records between 1 and almost 3 weeks
* 90 % of all orders arrives earlier as announced at customer
* Regarding delays 6.9 % of all orders arrive later than announced

#### Delivery times in non-urban areas quite long

![Screenshot 2023-01-25 at 13 30 01](https://user-images.githubusercontent.com/99658869/214563724-abd77c5d-71e8-4cb8-a10b-04d435192960.png)

* Long delivery times happen everywhere
* Short delivery times less likely with distance from São Paulo
* Brazilian Post Office is unreliable and unfit for Eniac, especially outside SE Brazil

#### Opportunities of Brazilian market:

* Most expensive Iphones in the world (9to5mac.com) and is one of Apple’s assemblers for iphones
* 4th largest internet market globally
* Market shares: 
  * Apple tablets: 23.76% (3rd place – statcounter.com – Last 12 months)
  * Apple mobile phone: 16.67% (3rd place- statcounter.com – Last 12 months)
  * OS X: 9.21% (2020 – Statista.com)
* 4 million iPhones, average price 7,500 Reals = **51 billion € market size iPhones** (apple.com/br)
* **E-commerce market** > $49 Billion by 2022 > $86 Billion by 2025 and increasing with **20% growth rate

#### Recommendation for action:

eCommerce service provider Magist seems not be a good starting point to enter brazilian market, because:
* Magist is dominated from low-value-orders concerning tech products
* Average delivery time an Magist is 1-3 weeks, 10 % of all deliveries are delayed

## Not sign 3y-contract with Magist

#### Future recommandation:

* Analysis of alternative eCommerce platforms
* Consideration of use of last mile transportation service providers for urban areas to provide next-day-delivery


