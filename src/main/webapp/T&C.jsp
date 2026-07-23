<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Terms & Conditions</title>
    
    <style>
        :root {
            --primary-color: #0f172a; /* Deeper slate tone for legal/formal pages */
            --accent-color: #2563eb;
            --bg-color: #f8fafc;
            --card-bg: #ffffff;
            --text-dark: #334155;
            --text-muted: #64748b;
            --border-color: #e2e8f0;
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
            line-height: 1.7;
            padding: 40px 20px;
        }

        .container {
            max-width: 850px;
            margin: 0 auto;
        }

        /* Header Section */
        .header {
            text-align: center;
            margin-bottom: 35px;
            padding-bottom: 25px;
            border-bottom: 2px solid var(--border-color);
        }

        .header h1 {
            font-size: 2.1rem;
            color: var(--primary-color);
            margin-bottom: 8px;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .header p {
            color: var(--text-muted);
            font-size: 0.95rem;
        }

        /* Document Container */
        .document-card {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 36px 40px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.04);
        }

        .legal-section {
            margin-bottom: 28px;
        }

        .legal-section:last-child {
            margin-bottom: 0;
        }

        .section-title {
            font-size: 1.15rem;
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .section-title::before {
            content: "";
            display: inline-block;
            width: 4px;
            height: 16px;
            background-color: var(--accent-color);
            border-radius: 2px;
        }

        .legal-text {
            color: var(--text-dark);
            font-size: 0.95rem;
            margin-bottom: 12px;
        }

        .legal-list {
            list-style-type: disc;
            padding-left: 20px;
            color: var(--text-dark);
            font-size: 0.95rem;
        }

        .legal-list li {
            margin-bottom: 8px;
        }

        /* Navigation / Action */
        .actions {
            margin-top: 35px;
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
            font-size: 0.95rem;
            transition: opacity 0.2s ease, transform 0.1s ease;
            box-shadow: 0 4px 6px -1px rgba(15, 23, 42, 0.15);
        }

        .btn-home:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }

        /* Responsive */
        @media (max-width: 640px) {
            body {
                padding: 20px 12px;
            }
            .document-card {
                padding: 24px 20px;
            }
            .header h1 {
                font-size: 1.6rem;
            }
        }
    </style>
</head>
<body>

    <div class="container">
        <!-- Main Header -->
        <header class="header">
            <h1>Seller Terms & Agreement</h1>
            <p>Last Updated: October 2023 &bull; Please read carefully before onboarding</p>
        </header>

        <!-- Legal Document Content -->
        <main class="document-card">

            <!-- Section 1 -->
            <section class="legal-section">
                <h2 class="section-title">1. Account Registration & Merchant Status</h2>
                <p class="legal-text">
                    By registering as a merchant on our platform, you represent and warrant that all business details, tax identification, and banking information provided are accurate and current.
                </p>
                <ul class="legal-list">
                    <li>Sellers must maintain active contact credentials at all times.</li>
                    <li>Account credentials must remain confidential and cannot be transferred without written approval.</li>
                </ul>
            </section>

            <!-- Section 2 -->
            <section class="legal-section">
                <h2 class="section-title">2. Financial Terms & Payouts</h2>
                <p class="legal-text">
                    Platform transaction fees and commissions are deducted automatically from gross sales proceeds before payout initiation.
                </p>
                <ul class="legal-list">
                    <li>Payouts are processed on a bi-weekly cycle to the verified bank account on record.</li>
                    <li>The platform reserves the right to hold payouts in reserve to cover prospective buyer refunds or disputes.</li>
                </ul>
            </section>

            <!-- Section 3 -->
            <section class="legal-section">
                <h2 class="section-title">3. Intellectual Property Rights</h2>
                <p class="legal-text">
                    Sellers retain ownership of their proprietary logos and product media, but grant the platform a non-exclusive license to use such media for promotional and operational purposes.
                </p>
                <ul class="legal-list">
                    <li>Sellers guarantee that listed items do not infringe on third-party trademarks, copyrights, or patents.</li>
                </ul>
            </section>

            <!-- Section 4 -->
            <section class="legal-section">
                <h2 class="section-title">4. Termination & Account Suspension</h2>
                <p class="legal-text">
                    Either party may terminate this agreement with 30 days written notice. Immediate account suspension may occur under the following conditions:
                </p>
                <ul class="legal-list">
                    <li>Repeated failure to meet fulfillment standards or customer service SLAs.</li>
                    <li>Involvement in fraudulent activities, selling counterfeit goods, or violating platform integrity standards.</li>
                </ul>
            </section>

            <!-- Section 5 -->
            <section class="legal-section">
                <h2 class="section-title">5. Limitation of Liability</h2>
                <p class="legal-text">
                    The platform shall not be liable for indirect, incidental, or consequential damages resulting from lost profits, network downtime, or third-party delivery delays.
                </p>
            </section>

        </main>

        <!-- Back to Home Button -->
        <div class="actions">
            <a href="SellerHomeServlet" class="btn-home">
                &#8592; Back to Home
            </a>
        </div>
    </div>

</body>
</html>