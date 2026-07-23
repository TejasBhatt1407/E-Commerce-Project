<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Guidelines & Merchant Policies</title>
    
    <style>
        :root {
            --primary-color: #2563eb;
            --primary-hover: #1d4ed8;
            --bg-color: #f8fafc;
            --card-bg: #ffffff;
            --text-dark: #1e293b;
            --text-muted: #64748b;
            --border-color: #e2e8f0;
            --accent-light: #eff6ff;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
        }

        body {
            background-color: var(--bg-color);
            color: var(--text-dark);
            line-height: 1.6;
            padding: 40px 20px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
        }

        /* Header Section */
        .header {
            text-align: center;
            margin-bottom: 40px;
            padding: 20px;
        }

        .header h1 {
            font-size: 2.25rem;
            color: var(--text-dark);
            margin-bottom: 10px;
            font-weight: 700;
        }

        .header p {
            color: var(--text-muted);
            font-size: 1.1rem;
        }

        /* Cards Grid */
        .policy-grid {
            display: grid;
            gap: 24px;
        }

        .policy-card {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 28px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .policy-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.08);
        }

        .policy-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 16px;
        }

        .policy-icon {
            background: var(--accent-light);
            color: var(--primary-color);
            width: 44px;
            height: 44px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 1.2rem;
            flex-shrink: 0;
        }

        .policy-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--text-dark);
        }

        .policy-list {
            list-style: none;
            padding-left: 0;
        }

        .policy-list li {
            position: relative;
            padding-left: 24px;
            margin-bottom: 10px;
            color: var(--text-muted);
            font-size: 0.95rem;
        }

        .policy-list li:last-child {
            margin-bottom: 0;
        }

        .policy-list li::before {
            content: "•";
            color: var(--primary-color);
            font-weight: bold;
            font-size: 1.4rem;
            position: absolute;
            left: 6px;
            top: -4px;
        }

        /* Navigation / Footer */
        .actions {
            margin-top: 40px;
            text-align: center;
        }

        .btn-home {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background-color: var(--primary-color);
            color: #ffffff;
            text-decoration: none;
            padding: 12px 28px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1rem;
            transition: background-color 0.2s ease, transform 0.1s ease;
            box-shadow: 0 4px 6px -1px rgba(37, 99, 235, 0.2);
        }

        .btn-home:hover {
            background-color: var(--primary-hover);
            transform: translateY(-1px);
        }

        /* Responsive Design */
        @media (max-width: 640px) {
            body {
                padding: 20px 12px;
            }
            .header h1 {
                font-size: 1.75rem;
            }
            .policy-card {
                padding: 20px;
            }
        }
    </style>
</head>
<body>

    <div class="container">
        <!-- Main Header -->
        <header class="header">
            <h1>Seller Operational Rules & Standards</h1>
            <p>Guidelines to maintain a fair, transparent, and successful storefront.</p>
        </header>

        <!-- Rules & Policies List -->
        <main class="policy-grid">

            <!-- Rule 1 -->
            <section class="policy-card">
                <div class="policy-header">
                    <div class="policy-icon">1</div>
                    <h2 class="policy-title">Product & Listing Quality</h2>
                </div>
                <ul class="policy-list">
                    <li>Sellers must list only genuine, authentic items with accurate descriptions and titles.</li>
                    <li>Stock levels must be updated in real-time to avoid listing out-of-stock inventory.</li>
                    <li>Prohibited, illegal, or hazardous items will be immediately delisted upon discovery.</li>
                </ul>
            </section>

            <!-- Rule 2 -->
            <section class="policy-card">
                <div class="policy-header">
                    <div class="policy-icon">2</div>
                    <h2 class="policy-title">Order Fulfillment & Shipping</h2>
                </div>
                <ul class="policy-list">
                    <li>All orders must be dispatched within the designated dispatch window (24–48 hours).</li>
                    <li>Sellers must use authorized courier partners for trackable shipments.</li>
                    <li>Consistently late orders or excessive seller cancellations will result in a penalty score.</li>
                </ul>
            </section>

            <!-- Rule 3 -->
            <section class="policy-card">
                <div class="policy-header">
                    <div class="policy-icon">3</div>
                    <h2 class="policy-title">Customer Interaction & Code of Conduct</h2>
                </div>
                <ul class="policy-list">
                    <li>Maintain professional, respectful, and prompt communication for buyer inquiries.</li>
                    <li>Attempting to direct buyers off-platform for payment transactions is strictly prohibited.</li>
                    <li>Manipulating customer ratings, reviews, or feedback will lead to permanent suspension.</li>
                </ul>
            </section>

            <!-- Rule 4 -->
            <section class="policy-card">
                <div class="policy-header">
                    <div class="policy-icon">4</div>
                    <h2 class="policy-title">Returns & Refund Compliance</h2>
                </div>
                <ul class="policy-list">
                    <li>Sellers must honor the platform's standard return policy without hidden fees.</li>
                    <li>Returned items must be inspected within 2 business days of receipt to authorize payouts or replacements.</li>
                    <li>Disputes regarding damaged or incorrect returns must follow official seller-support protocols.</li>
                </ul>
            </section>

        </main>

        <!-- Back to Home Action -->
        <div class="actions">
            <a href="SellerHomeServlet" class="btn-home">
                &#8592; Back to Home
            </a>
        </div>
    </div>

</body>
</html>