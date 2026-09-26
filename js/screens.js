/**
 * ReCyclo Screen Renderers & Interactive Logic
 * Renders each application view with state binding and smooth event handling
 */

const Screens = {
  // ==========================================
  // 1. SPLASH SCREEN
  // ==========================================
  renderSplash() {
    return `
      <div class="screen-view screen-splash active-screen no-bottom-nav" id="screen-splash">
        <div class="splash-logo-container">
          <img src="assets/recyclo-logo.jpg" alt="ReCyclo – Turning Waste into Worth" class="splash-logo-img">
          <div class="splash-loader"></div>
          <p style="margin-top: 18px; font-size: 13px; color: var(--color-text-secondary); font-weight: 500;">
            Loading your eco-dashboard...
          </p>
        </div>
      </div>
    `;
  },

  // ==========================================
  // 2. ONBOARDING
  // ==========================================
  renderOnboarding(step = 1) {
    const isStep1 = step === 1;

    const heading = isStep1
      ? 'Recycle Today, Create a Better Tomorrow.'
      : 'Your Waste Can Make a Difference.';

    const description = isStep1
      ? 'Turn your everyday waste into a greener future.'
      : 'Schedule pickups, connect with collectors, get paid, and help keep our planet clean.';

    const heroIcon = isStep1 ? 'recycle' : 'truck';

    return `
      <div class="screen-view screen-onboarding active-screen no-bottom-nav" id="screen-onboarding">
        <div class="onboarding-top">
          <div style="display: flex; align-items: center; gap: 8px;">
            <img src="assets/recyclo-logo.jpg" alt="ReCyclo" style="height: 32px; width: 32px; border-radius: 8px; object-fit: contain;">
            <span style="font-family: var(--font-family-display); font-weight: 800; font-size: 18px; color: var(--color-brand-dark);">ReCyclo</span>
          </div>
          <button class="btn btn-ghost btn-sm" id="onboarding-skip-btn" style="color: var(--color-text-secondary);">
            Skip
          </button>
        </div>

        <div class="onboarding-slide-content">
          <div class="onboarding-hero-card">
            <div class="onboarding-hero-icon-ring">
              ${Icons.get(heroIcon, { active: true, size: 52 })}
            </div>
            <div style="position: absolute; bottom: 16px; font-size: 12px; font-weight: 700; color: var(--color-primary); letter-spacing: 0.05em; text-transform: uppercase;">
              ${isStep1 ? 'Smart Waste Sorting' : 'Instant Neighborhood Pickups'}
            </div>
          </div>

          <h2 class="onboarding-title">${heading}</h2>
          <p class="onboarding-desc">${description}</p>
        </div>

        <div class="onboarding-footer">
          <div class="dots-indicator">
            <div class="dot ${isStep1 ? 'active' : ''}"></div>
            <div class="dot ${!isStep1 ? 'active' : ''}"></div>
          </div>

          ${isStep1
            ? `<button class="btn btn-primary btn-block btn-lg" id="onboarding-next-btn">
                 Next ${Icons.get('chevron-right', { size: 18 })}
               </button>`
            : `<button class="btn btn-primary btn-block btn-lg" id="onboarding-start-btn">
                 Get Started
               </button>`
          }
        </div>
      </div>
    `;
  },

  // ==========================================
  // 3. LOGIN & SIGNUP
  // ==========================================
  renderLogin() {
    return `
      <div class="screen-view screen-auth active-screen no-bottom-nav" id="screen-login">
        <div class="auth-header">
          <img src="assets/recyclo-logo.jpg" alt="ReCyclo" class="auth-logo-img">
          <h2 class="auth-title">Welcome Back</h2>
          <p class="auth-subtitle">Sign in to manage your recycling & collections</p>
        </div>

        <form id="login-form" novalidate>
          <div class="form-group">
            <label class="form-label" for="login-identifier">Email / Phone Number</label>
            <div class="input-wrapper">
              <span class="input-icon-left">${Icons.get('user', { size: 18 })}</span>
              <input type="text" id="login-identifier" class="form-input has-icon-left" placeholder="e.g. alex.rivers@recyclo.eco" value="alex.rivers@recyclo.eco" required>
            </div>
            <div class="form-feedback error" id="login-identifier-error" style="display: none;">
              Please enter your registered email or phone
            </div>
          </div>

          <div class="form-group">
            <div style="display: flex; justify-content: space-between; align-items: center;">
              <label class="form-label" for="login-password">Password</label>
              <button type="button" class="btn-ghost" id="forgot-password-btn" style="font-size: 12px; color: var(--color-primary); padding: 0;">
                Forgot Password?
              </button>
            </div>
            <div class="input-wrapper">
              <input type="password" id="login-password" class="form-input" placeholder="Enter your password" value="password123" required>
            </div>
            <div class="form-feedback error" id="login-password-error" style="display: none;">
              Password must be at least 6 characters
            </div>
          </div>

          <button type="submit" class="btn btn-primary btn-block btn-lg" id="login-submit-btn" style="margin-top: 8px;">
            Login
          </button>
        </form>

        <div class="auth-divider">
          <span>OR</span>
        </div>

        <button type="button" class="btn btn-google btn-block" id="google-login-btn">
          <svg width="18" height="18" viewBox="0 0 24 24">
            <path fill="#4285F4" d="M23.745 12.27c0-.7-.06-1.4-.19-2.07H12v4.51h6.6c-.29 1.52-1.14 2.8-2.4 3.67v3.05h3.88c2.27-2.09 3.665-5.17 3.665-9.16z"/>
            <path fill="#34A853" d="M12 24c3.24 0 5.95-1.08 7.93-2.91l-3.88-3.05c-1.08.72-2.45 1.16-4.05 1.16-3.12 0-5.77-2.1-6.72-4.94H1.24v3.15C3.26 21.36 7.33 24 12 24z"/>
            <path fill="#FBBC05" d="M5.28 14.26c-.25-.72-.38-1.49-.38-2.26s.13-1.54.38-2.26V6.59H1.24C.45 8.16 0 9.92 0 12s.45 3.84 1.24 5.41l4.04-3.15z"/>
            <path fill="#EA4335" d="M12 4.75c1.77 0 3.35.61 4.6 1.8l3.42-3.42C17.95 1.19 15.24 0 12 0 7.33 0 3.26 2.64 1.24 6.59l4.04 3.15c.95-2.84 3.6-4.99 6.72-4.99z"/>
          </svg>
          Continue with Google
        </button>

        <div style="text-align: center; margin-top: var(--spacing-xl); font-size: 14px; color: var(--color-text-secondary);">
          Don't have an account? 
          <button type="button" class="btn-ghost" id="to-signup-btn" style="color: var(--color-primary); font-weight: 700; padding: 0 4px;">
            Create Account
          </button>
        </div>
      </div>
    `;
  },

  renderSignup() {
    return `
      <div class="screen-view screen-auth active-screen no-bottom-nav" id="screen-signup">
        <div class="auth-header">
          <img src="assets/recyclo-logo.jpg" alt="ReCyclo" class="auth-logo-img">
          <h2 class="auth-title">Create Account</h2>
          <p class="auth-subtitle">Join thousands making waste useful every day</p>
        </div>

        <form id="signup-form" novalidate>
          <div class="form-group">
            <label class="form-label" for="signup-name">Full Name</label>
            <input type="text" id="signup-name" class="form-input" placeholder="e.g. Alex Rivers" value="Alex Rivers" required>
          </div>

          <div class="form-group">
            <label class="form-label" for="signup-email">Email Address</label>
            <input type="email" id="signup-email" class="form-input" placeholder="name@example.com" value="alex.rivers@recyclo.eco" required>
          </div>

          <div class="form-group">
            <label class="form-label" for="signup-phone">Phone Number</label>
            <input type="tel" id="signup-phone" class="form-input" placeholder="+91 98765 43210" value="+91 98765 43210" required>
          </div>

          <div class="form-group">
            <label class="form-label" for="signup-location">Default Pickup Location</label>
            <input type="text" id="signup-location" class="form-input" placeholder="Apartment / Street / City" value="402 Oakwood Heights, Bengaluru" required>
          </div>

          <div class="form-group">
            <label class="form-label" for="signup-password">Password</label>
            <input type="password" id="signup-password" class="form-input" placeholder="Min. 8 characters" value="password123" required>
          </div>

          <div class="form-group">
            <label class="form-label" for="signup-confirm-password">Confirm Password</label>
            <input type="password" id="signup-confirm-password" class="form-input" placeholder="Re-enter password" value="password123" required>
          </div>

          <label class="checkbox-container" style="margin: 14px 0;">
            <input type="checkbox" id="signup-terms" checked required>
            <span class="custom-checkbox">
              ${Icons.get('check', { size: 14 })}
            </span>
            <span>I agree to the <a href="#" style="color: var(--color-primary); text-decoration: underline;">Terms of Service</a> & <a href="#" style="color: var(--color-primary); text-decoration: underline;">Privacy Policy</a></span>
          </label>

          <button type="submit" class="btn btn-primary btn-block btn-lg" id="signup-submit-btn">
            Create Account
          </button>
        </form>

        <div style="text-align: center; margin-top: var(--spacing-lg); font-size: 14px; color: var(--color-text-secondary);">
          Already have an account? 
          <button type="button" class="btn-ghost" id="to-login-btn" style="color: var(--color-primary); font-weight: 700; padding: 0 4px;">
            Sign In
          </button>
        </div>
      </div>
    `;
  },

  // ==========================================
  // 4. HOME SCREEN DASHBOARD
  // ==========================================
  renderHome() {
    const user = state.state.currentUser;
    const activeReq = state.state.activeRequest;
    const collectors = MockData.collectors.slice(0, 3);

    const categoriesPills = MockData.categories.map(cat => `
      <div class="category-pill-card ${cat.id === 'plastic' ? 'active' : ''}" data-category-id="${cat.id}">
        <div class="category-pill-icon">
          ${Icons.get(cat.icon, { active: cat.id === 'plastic', size: 20 })}
        </div>
        <span style="font-weight: 600; font-size: 13px;">${cat.name}</span>
      </div>
    `).join('');

    const collectorsHtml = collectors.map(col => Components.renderCollectorCard(col)).join('');

    return `
      <div class="screen-view screen-home active-screen" id="screen-home">
        <!-- Top Header -->
        <div class="home-top-header">
          <div style="display: flex; align-items: center; gap: 10px;">
            <img src="${user.avatar}" alt="${user.name}" style="width: 44px; height: 44px; border-radius: var(--radius-full); object-fit: cover; border: 2px solid #FFFFFF; box-shadow: var(--shadow-sm);">
            <div class="home-user-greeting">
              <h1>Hello, ${user.name.split(' ')[0]} 👋</h1>
              <p>Let’s make your waste useful today.</p>
            </div>
          </div>
          <button class="notification-bell-btn" id="home-bell-btn" aria-label="Notifications">
            ${Icons.get('bell', { size: 20 })}
            ${state.state.unreadNotificationCount > 0 ? `<span class="unread-badge-pill"></span>` : ''}
          </button>
        </div>

        <!-- Main Prominent CTA Card -->
        <div class="hero-add-waste-card" id="home-hero-cta">
          <div class="hero-card-tag">
            ${Icons.get('leaf', { size: 12, active: true })} Instant Doorstep Pickup
          </div>
          <h2 class="hero-card-title">Turn Your Waste<br>Into Cash Today</h2>
          <p class="hero-card-sub">Upload a quick photo, select your items, and connect with nearby certified recyclers.</p>
          <button class="btn btn-primary btn-lg" id="home-add-waste-btn" style="background: #FFFFFF; color: var(--color-brand-dark); font-weight: 700; box-shadow: 0 4px 14px rgba(0,0,0,0.15);">
            ${Icons.get('add-waste', { size: 20, active: true })} Add Your Waste
          </button>
        </div>

        <!-- Quick Actions Grid -->
        <div class="quick-actions-bar">
          <div class="quick-action-item" data-action="quick-add">
            <div class="quick-action-icon">${Icons.get('add-waste', { size: 20 })}</div>
            <span class="quick-action-label">Add Waste</span>
          </div>
          <div class="quick-action-item" data-action="quick-collectors">
            <div class="quick-action-icon">${Icons.get('truck', { size: 20 })}</div>
            <span class="quick-action-label">Find Collector</span>
          </div>
          <div class="quick-action-item" data-action="quick-requests">
            <div class="quick-action-icon">${Icons.get('requests', { size: 20 })}</div>
            <span class="quick-action-label">My Requests</span>
          </div>
          <div class="quick-action-item" data-action="quick-payments">
            <div class="quick-action-icon">${Icons.get('card', { size: 20 })}</div>
            <span class="quick-action-label">Payments</span>
          </div>
        </div>

        <!-- Your Active Request Live Status Banner -->
        ${activeReq ? `
          <div class="active-request-banner" id="home-active-request-card">
            <div class="request-banner-header">
              <div style="display: flex; align-items: center; gap: 6px;">
                <span class="live-pulse-dot"></span>
                <span style="font-size: 11px; font-weight: 800; color: var(--color-primary); letter-spacing: 0.04em; text-transform: uppercase;">
                  Active Pickup • ${activeReq.id}
                </span>
              </div>
              <span class="badge badge-primary" style="font-size: 11px;">
                ${activeReq.status.replace(/_/g, ' ').toUpperCase()}
              </span>
            </div>

            <div style="display: flex; justify-content: space-between; align-items: center;">
              <div>
                <div style="font-weight: 700; font-size: 15px; color: var(--color-brand-dark);">
                  ${activeReq.wasteType} (${activeReq.quantity})
                </div>
                <div style="font-size: 12px; color: var(--color-text-secondary); margin-top: 2px;">
                  Collector: <strong>${activeReq.collectorName}</strong> • ETA: ~${activeReq.etaMinutes} mins
                </div>
              </div>
              <button class="btn btn-primary btn-sm" id="home-track-active-btn">
                Track Live
              </button>
            </div>
          </div>
        ` : ''}

        <!-- Environmental Impact Dashboard Summary -->
        <div class="eco-insights-card">
          <div style="display: flex; align-items: center; justify-content: space-between;">
            <div style="display: flex; align-items: center; gap: 6px;">
              <span style="color: var(--color-primary);">${Icons.get('leaf', { size: 18, active: true })}</span>
              <span style="font-size: 13px; font-weight: 700; color: var(--color-brand-dark);">Your Environmental Impact</span>
            </div>
            <span style="font-size: 11px; color: var(--color-text-muted);">Estimated</span>
          </div>
          <div class="insights-grid">
            <div class="insight-metric-box">
              <div class="insight-val">${user.stats.totalRecycledKg} kg</div>
              <div class="insight-lbl">Waste Recycled</div>
            </div>
            <div class="insight-metric-box">
              <div class="insight-val">${user.stats.collectionsCompleted}</div>
              <div class="insight-lbl">Pickups Done</div>
            </div>
            <div class="insight-metric-box">
              <div class="insight-val">${user.stats.moneyEarned}</div>
              <div class="insight-lbl">Earned</div>
            </div>
          </div>
        </div>

        <!-- Waste Categories Section -->
        <div class="section-header">
          <h3 class="section-title">Waste Categories</h3>
          <span class="section-link" id="home-view-categories-btn">View All</span>
        </div>
        <div class="horizontal-categories-scroll">
          ${categoriesPills}
        </div>

        <!-- Nearby Collectors Section -->
        <div class="section-header">
          <h3 class="section-title">Nearby Collectors</h3>
          <span class="section-link" id="home-view-collectors-btn">See All (4)</span>
        </div>
        <div class="collectors-stack">
          ${collectorsHtml}
        </div>
      </div>

      ${Components.renderBottomNav('home')}
    `;
  },

  // ==========================================
  // 5. ADD WASTE FLOW (5 STEPS)
  // ==========================================
  renderAddWaste(currentStep = 1) {
    const draft = state.state.wasteDraft;
    const progressPercent = (currentStep / 5) * 100;

    let stepHtml = '';

    // Step 1: Photo Experience
    if (currentStep === 1) {
      stepHtml = `
        <div class="step-container">
          <h3 style="font-family: var(--font-family-display); font-size: 20px; font-weight: 800; color: var(--color-brand-dark); margin-bottom: 6px;">
            Step 1: Add a Photo of Your Waste
          </h3>
          <p style="font-size: 13.5px; color: var(--color-text-secondary); margin-bottom: 16px;">
            Take a crisp photo or upload from gallery. We'll suggest matching categories!
          </p>

          ${draft.photoUrl ? `
            <div class="uploaded-preview-container">
              <img src="${draft.photoUrl}" alt="Waste Preview" class="uploaded-preview-img">
              <div class="preview-overlay-actions">
                <button class="btn btn-secondary btn-sm" id="waste-retake-photo-btn" style="background: rgba(255,255,255,0.9);">
                  Retake
                </button>
                <button class="btn btn-danger btn-sm" id="waste-remove-photo-btn" style="background: #EF4444; color: #FFFFFF;">
                  Remove
                </button>
              </div>
            </div>
            <div class="suggested-type-badge">
              <span style="color: var(--color-primary);">${Icons.get('shield-check', { size: 18, active: true })}</span>
              <div>
                <strong>Suggested waste type:</strong> ${draft.suggestedCategory}
                <span style="font-size: 11px; color: var(--color-text-muted); display: block;">You can manually change this in the next step.</span>
              </div>
            </div>
          ` : `
            <div class="camera-viewfinder-box" id="camera-trigger-box">
              <div style="width: 64px; height: 64px; border-radius: 50%; background: var(--color-primary-light); color: var(--color-primary); display: flex; align-items: center; justify-content: center; margin-bottom: 12px;">
                ${Icons.get('camera', { size: 32, active: true })}
              </div>
              <span style="font-weight: 700; font-size: 15px; color: var(--color-brand-dark);">Tap to Take Photo</span>
              <span style="font-size: 12px; color: var(--color-text-muted); margin-top: 4px;">Camera viewfinder simulation</span>
            </div>
            <div class="camera-btn-group">
              <button class="btn btn-secondary btn-block" id="waste-camera-sample-btn">
                ${Icons.get('camera', { size: 18 })} Take Photo
              </button>
              <button class="btn btn-outline btn-block" id="waste-gallery-sample-btn">
                ${Icons.get('gallery', { size: 18 })} Choose Gallery
              </button>
            </div>
          `}

          <button class="btn btn-primary btn-block btn-lg" id="add-waste-next-1" style="margin-top: 24px;">
            Continue to Waste Details ${Icons.get('chevron-right', { size: 18 })}
          </button>
        </div>
      `;
    } 
    // Step 2: Select Waste Type
    else if (currentStep === 2) {
      const categoryCards = MockData.categories.map(cat => {
        const isSelected = draft.category === cat.id;
        return `
          <div class="category-select-card ${isSelected ? 'selected' : ''}" data-cat-id="${cat.id}">
            <div class="category-icon-bubble">
              ${Icons.get(cat.icon, { active: isSelected, size: 22 })}
            </div>
            <div>
              <div style="font-weight: 700; font-size: 14px; color: var(--color-brand-dark);">${cat.name}</div>
              <div style="font-size: 11px; color: var(--color-primary); font-weight: 600; margin-top: 2px;">${cat.avgRate}</div>
            </div>
          </div>
        `;
      }).join('');

      stepHtml = `
        <div class="step-container">
          <h3 style="font-family: var(--font-family-display); font-size: 20px; font-weight: 800; color: var(--color-brand-dark); margin-bottom: 6px;">
            Step 2: Select Waste Type
          </h3>
          <p style="font-size: 13.5px; color: var(--color-text-secondary); margin-bottom: 16px;">
            Choose the primary category for this collection.
          </p>

          <div class="category-selection-grid">
            ${categoryCards}
          </div>

          <div style="display: flex; gap: 10px; margin-top: 24px;">
            <button class="btn btn-outline" id="add-waste-prev" style="flex: 0.8;">Back</button>
            <button class="btn btn-primary btn-lg" id="add-waste-next-2" style="flex: 1.5;">Next: Quantity</button>
          </div>
        </div>
      `;
    }
    // Step 3: Quantity
    else if (currentStep === 3) {
      stepHtml = `
        <div class="step-container">
          <h3 style="font-family: var(--font-family-display); font-size: 20px; font-weight: 800; color: var(--color-brand-dark); margin-bottom: 6px;">
            Step 3: Approximate Quantity
          </h3>
          <p style="font-size: 13.5px; color: var(--color-text-secondary); margin-bottom: 16px;">
            Estimate the weight in kg. Collectors will verify with calibrated scales on pickup.
          </p>

          <div class="quantity-box-card">
            <span style="font-size: 12px; font-weight: 700; color: var(--color-text-muted); text-transform: uppercase; letter-spacing: 0.05em;">Estimated Weight</span>
            <div class="quantity-stepper">
              <button class="btn-icon btn-secondary" id="qty-minus" style="width: 46px; height: 46px; font-size: 22px; font-weight: bold;">−</button>
              <div class="quantity-stepper-val" id="qty-display">${draft.quantityKg.toFixed(1)} <span style="font-size: 16px; font-weight: 600; color: var(--color-text-secondary);">kg</span></div>
              <button class="btn-icon btn-secondary" id="qty-plus" style="width: 46px; height: 46px; font-size: 22px; font-weight: bold;">+</button>
            </div>

            <div class="preset-pills-row">
              <button class="chip ${draft.quantityKg === 2 ? 'active' : ''}" data-qty="2">2 - 5 kg</button>
              <button class="chip ${draft.quantityKg === 8.5 ? 'active' : ''}" data-qty="8.5">5 - 15 kg</button>
              <button class="chip ${draft.quantityKg === 20 ? 'active' : ''}" data-qty="20">15 - 30 kg</button>
              <button class="chip ${draft.quantityKg === 50 ? 'active' : ''}" data-qty="50">30+ kg Bulk</button>
            </div>
          </div>

          <div class="card" style="background: var(--color-primary-surface); border-color: rgba(0, 168, 132, 0.2); padding: 14px;">
            <div style="display: flex; justify-content: space-between; align-items: center;">
              <span style="font-size: 13px; color: var(--color-text-secondary);">Estimated Payout:</span>
              <span style="font-family: var(--font-family-display); font-size: 18px; font-weight: 800; color: var(--color-primary);" id="estimated-payout-display">
                ₹${(draft.quantityKg * 18).toFixed(2)}
              </span>
            </div>
            <div style="font-size: 11px; color: var(--color-text-muted); margin-top: 4px;">
              Based on standard benchmark rates for ${draft.category.toUpperCase()}.
            </div>
          </div>

          <div style="display: flex; gap: 10px; margin-top: 24px;">
            <button class="btn btn-outline" id="add-waste-prev" style="flex: 0.8;">Back</button>
            <button class="btn btn-primary btn-lg" id="add-waste-next-3" style="flex: 1.5;">Next: Notes</button>
          </div>
        </div>
      `;
    }
    // Step 4: Description / Notes
    else if (currentStep === 4) {
      stepHtml = `
        <div class="step-container">
          <h3 style="font-family: var(--font-family-display); font-size: 20px; font-weight: 800; color: var(--color-brand-dark); margin-bottom: 6px;">
            Step 4: Optional Description
          </h3>
          <p style="font-size: 13.5px; color: var(--color-text-secondary); margin-bottom: 16px;">
            Add instructions for the collector (e.g., bag count, gate code, elevator).
          </p>

          <div class="form-group">
            <label class="form-label" for="waste-notes-input">Notes for Collector</label>
            <textarea id="waste-notes-input" class="form-input" rows="4" style="resize: none;" placeholder="e.g. 2 tied bags left near apartment door">${draft.notes}</textarea>
          </div>

          <div class="card" style="background: #FFFFFF; padding: 14px;">
            <span style="font-size: 12px; font-weight: 700; color: var(--color-brand-dark);">Helpful Tips:</span>
            <ul style="font-size: 12px; color: var(--color-text-secondary); margin-left: 18px; margin-top: 6px; line-height: 1.6;">
              <li>Please keep recyclable items clean and dry.</li>
              <li>Separate glass items into a secure container to prevent breakage.</li>
            </ul>
          </div>

          <div style="display: flex; gap: 10px; margin-top: 24px;">
            <button class="btn btn-outline" id="add-waste-prev" style="flex: 0.8;">Back</button>
            <button class="btn btn-primary btn-lg" id="add-waste-next-4" style="flex: 1.5;">Next: Location</button>
          </div>
        </div>
      `;
    }
    // Step 5: Pickup Location
    else if (currentStep === 5) {
      stepHtml = `
        <div class="step-container">
          <h3 style="font-family: var(--font-family-display); font-size: 20px; font-weight: 800; color: var(--color-brand-dark); margin-bottom: 6px;">
            Step 5: Confirm Pickup Address
          </h3>
          <p style="font-size: 13.5px; color: var(--color-text-secondary); margin-bottom: 16px;">
            Collectors in your neighborhood will navigate directly to this address.
          </p>

          <div class="location-map-mock">
            <div class="location-map-grid-pattern"></div>
            <div class="map-pin-pulse">
              ${Icons.get('location', { size: 36, active: true })}
            </div>
            <span style="position: absolute; bottom: 8px; font-size: 11px; font-weight: 600; color: var(--color-brand-dark); background: rgba(255,255,255,0.85); padding: 2px 8px; border-radius: 12px;">
              GPS Pin Verified
            </span>
          </div>

          <div class="form-group">
            <label class="form-label">Pickup Address</label>
            <input type="text" id="waste-address-input" class="form-input" value="${draft.address}">
          </div>

          <div style="display: flex; gap: 8px; margin-bottom: 16px;">
            <button class="chip active" style="font-size: 12px;">Home</button>
            <button class="chip" style="font-size: 12px;">Office</button>
            <button class="chip" style="font-size: 12px;">+ Add New</button>
          </div>

          <div style="display: flex; gap: 10px; margin-top: 24px;">
            <button class="btn btn-outline" id="add-waste-prev" style="flex: 0.8;">Back</button>
            <button class="btn btn-primary btn-lg" id="add-waste-find-collectors-btn" style="flex: 1.8;">
              ${Icons.get('search', { size: 18 })} Find Collectors
            </button>
          </div>
        </div>
      `;
    }

    return `
      <div class="screen-view screen-add-waste active-screen" id="screen-add-waste">
        ${Components.renderTopBar({ title: 'Add Your Waste', showBack: true })}

        <div class="stepper-header-bar">
          <div class="stepper-progress-track">
            <div class="stepper-progress-fill" style="width: ${progressPercent}%;"></div>
          </div>
          <div class="stepper-step-labels">
            <span class="${currentStep >= 1 ? 'active-step' : ''}">1 Waste</span>
            <span class="${currentStep >= 2 ? 'active-step' : ''}">2 Details</span>
            <span class="${currentStep >= 3 ? 'active-step' : ''}">3 Quantity</span>
            <span class="${currentStep >= 4 ? 'active-step' : ''}">4 Notes</span>
            <span class="${currentStep >= 5 ? 'active-step' : ''}">5 Location</span>
          </div>
        </div>

        ${stepHtml}
      </div>

      ${Components.renderBottomNav('add-waste')}
    `;
  },

  // ==========================================
  // 6. COLLECTOR MATCHING
  // ==========================================
  renderCollectorMatching() {
    const draft = state.state.wasteDraft;
    const collectors = MockData.collectors;

    const cardsHtml = collectors.map(col => Components.renderCollectorCard(col)).join('');

    return `
      <div class="screen-view active-screen" id="screen-collector-matching" style="background: var(--color-bg-app); padding-bottom: calc(var(--bottom-nav-height) + 16px);">
        ${Components.renderTopBar({ title: 'Collectors Near You', showBack: true })}

        <div style="padding: 12px 16px; background: #FFFFFF; border-bottom: 1px solid var(--color-border-subtle);">
          <div style="display: flex; justify-content: space-between; align-items: center;">
            <div>
              <span style="font-size: 14px; font-weight: 800; color: var(--color-brand-dark);">
                ${collectors.length} Verified Collectors
              </span>
              <span style="display: block; font-size: 12px; color: var(--color-text-secondary);">
                Matching: ${draft.category.toUpperCase()} (${draft.quantityKg} kg)
              </span>
            </div>
            <span class="badge badge-primary">Within 3.5 km</span>
          </div>
        </div>

        <div style="padding: 16px;">
          <div class="collectors-stack" id="matching-collectors-list">
            ${cardsHtml}
          </div>
        </div>
      </div>

      ${Components.renderBottomNav('collectors')}
    `;
  },

  // ==========================================
  // 7. COLLECTOR PROFILE
  // ==========================================
  renderCollectorProfile(collectorId = 'col-1') {
    const collector = MockData.collectors.find(c => c.id === collectorId) || MockData.collectors[0];

    const acceptedPills = collector.acceptedCategories.map(c => `
      <span class="chip active" style="font-size: 12px;">${c.toUpperCase()}</span>
    `).join('');

    const reviewsHtml = collector.reviews.map(r => `
      <div class="card" style="margin-bottom: 10px; padding: 12px;">
        <div style="display: flex; justify-content: space-between; align-items: center;">
          <span style="font-weight: 700; font-size: 13px; color: var(--color-brand-dark);">${r.author}</span>
          <span style="font-size: 11px; color: var(--color-text-muted);">${r.date}</span>
        </div>
        <div style="color: #F59E0B; font-size: 12px; margin: 2px 0;">★★★★★</div>
        <p style="font-size: 12.5px; color: var(--color-text-secondary); line-height: 1.4;">${r.text}</p>
      </div>
    `).join('');

    return `
      <div class="screen-view active-screen no-bottom-nav" id="screen-collector-profile" style="background: var(--color-bg-app); padding-bottom: 80px;">
        ${Components.renderTopBar({ title: 'Collector Profile', showBack: true })}

        <div class="collector-profile-hero">
          <img src="${collector.avatar}" alt="${collector.name}" class="collector-profile-avatar-lg">
          <h2 style="font-family: var(--font-family-display); font-size: 22px; font-weight: 800; color: var(--color-brand-dark);">
            ${collector.name}
          </h2>
          <span style="font-size: 13px; color: var(--color-text-secondary); margin-top: 2px;">${collector.agency}</span>

          <div style="display: flex; align-items: center; gap: 8px; margin-top: 8px;">
            ${collector.verified ? `
              <span class="badge badge-primary" style="display: flex; align-items: center; gap: 4px;">
                ${Icons.get('shield-check', { size: 14, active: true })} Verified Partner
              </span>
            ` : ''}
            <span class="badge ${collector.availability === 'available' ? 'badge-available' : 'badge-busy'}">
              <span class="badge-dot"></span> ${collector.availability.toUpperCase()}
            </span>
          </div>

          <div class="profile-stats-bar">
            <div class="profile-stat-box">
              <div style="font-weight: 800; color: #D97706; font-size: 16px;">★ ${collector.rating}</div>
              <div style="font-size: 11px; color: var(--color-text-muted);">${collector.reviewCount} Reviews</div>
            </div>
            <div class="profile-stat-box">
              <div style="font-weight: 800; color: var(--color-brand-dark); font-size: 16px;">${collector.completedCollections}</div>
              <div style="font-size: 11px; color: var(--color-text-muted);">Collections</div>
            </div>
            <div class="profile-stat-box">
              <div style="font-weight: 800; color: var(--color-primary); font-size: 16px;">${collector.distanceKm} km</div>
              <div style="font-size: 11px; color: var(--color-text-muted);">Distance</div>
            </div>
          </div>
        </div>

        <div style="padding: 16px;">
          <!-- About -->
          <div class="card" style="margin-bottom: 14px;">
            <h4 style="font-size: 14px; font-weight: 700; color: var(--color-brand-dark); margin-bottom: 6px;">About</h4>
            <p style="font-size: 13px; color: var(--color-text-secondary); line-height: 1.5;">${collector.about}</p>
          </div>

          <!-- Accepted Categories & Rates -->
          <div class="card" style="margin-bottom: 14px;">
            <h4 style="font-size: 14px; font-weight: 700; color: var(--color-brand-dark); margin-bottom: 8px;">Accepted Categories</h4>
            <div style="display: flex; gap: 6px; flex-wrap: wrap; margin-bottom: 10px;">
              ${acceptedPills}
            </div>
            <div style="font-size: 12px; color: var(--color-text-secondary); border-top: 1px solid var(--color-border-subtle); padding-top: 8px;">
              <strong>Rates:</strong> ${collector.rateCard}
            </div>
          </div>

          <!-- Service Area & Hours -->
          <div class="card" style="margin-bottom: 14px;">
            <div style="display: flex; gap: 10px; align-items: center; margin-bottom: 8px;">
              <span style="color: var(--color-primary);">${Icons.get('clock', { size: 18 })}</span>
              <span style="font-size: 13px; color: var(--color-brand-dark);"><strong>Working Hours:</strong> ${collector.workingHours}</span>
            </div>
            <div style="display: flex; gap: 10px; align-items: center;">
              <span style="color: var(--color-primary);">${Icons.get('location', { size: 18 })}</span>
              <span style="font-size: 13px; color: var(--color-brand-dark);"><strong>Service Area:</strong> ${collector.serviceArea}</span>
            </div>
          </div>

          <!-- Reviews -->
          <h4 style="font-size: 15px; font-weight: 800; color: var(--color-brand-dark); margin: 16px 0 10px;">Recent Reviews</h4>
          ${reviewsHtml}
        </div>

        <!-- Sticky Bottom Actions -->
        <div style="position: absolute; bottom: 0; left: 0; right: 0; background: #FFFFFF; border-top: 1px solid var(--color-border); padding: 12px 16px; display: flex; gap: 10px; z-index: 40;">
          <button class="btn btn-secondary btn-icon" id="profile-chat-btn" title="Message" data-col-id="${collector.id}">
            ${Icons.get('chat', { size: 20 })}
          </button>
          <button class="btn btn-secondary btn-icon" id="profile-call-btn" title="Call" data-col-id="${collector.id}">
            ${Icons.get('phone', { size: 20 })}
          </button>
          <button class="btn btn-primary btn-block" id="profile-schedule-btn" data-col-id="${collector.id}" style="flex: 1;">
            Schedule Pickup
          </button>
        </div>
      </div>
    `;
  },

  // ==========================================
  // 8. CHAT SYSTEM
  // ==========================================
  renderChat(collectorId = 'col-1') {
    const collector = MockData.collectors.find(c => c.id === collectorId) || MockData.collectors[0];
    const messages = state.state.chatMessages;

    const messagesHtml = messages.map(m => {
      const isSent = m.sender === 'user';
      if (m.isPickupSummary) {
        return `
          <div class="chat-bubble-row sent">
            <div class="chat-pickup-summary-card">
              <div style="display: flex; align-items: center; gap: 6px; margin-bottom: 6px;">
                <span style="color: var(--color-primary);">${Icons.get('calendar', { size: 16, active: true })}</span>
                <span style="font-weight: 800; font-size: 13px; color: var(--color-brand-dark);">Pickup Request Details</span>
              </div>
              <div style="font-size: 12px; color: var(--color-text-secondary); line-height: 1.5;">
                <strong>Waste:</strong> ${state.state.wasteDraft.category.toUpperCase()} (~${state.state.wasteDraft.quantityKg} kg)<br>
                <strong>Time:</strong> Today, ${state.state.wasteDraft.pickupTimeSlot}<br>
                <strong>Address:</strong> ${state.state.wasteDraft.address}
              </div>
              <div class="chat-time">${m.time}</div>
            </div>
          </div>
        `;
      }

      return `
        <div class="chat-bubble-row ${isSent ? 'sent' : 'received'}">
          ${!isSent ? `<img src="${collector.avatar}" style="width: 28px; height: 28px; border-radius: 50%; object-fit: cover;">` : ''}
          <div class="chat-bubble ${isSent ? 'sent' : 'received'}">
            <div>${m.text}</div>
            <div class="chat-time">${m.time}</div>
          </div>
        </div>
      `;
    }).join('');

    return `
      <div class="screen-view screen-chat active-screen no-bottom-nav" id="screen-chat">
        <!-- Chat Header -->
        <header class="top-bar">
          <div class="top-bar-left">
            <button class="btn-icon btn-ghost" id="chat-back-btn">
              ${Icons.get('chevron-left', { size: 22 })}
            </button>
          </div>
          <div style="display: flex; align-items: center; gap: 10px; flex: 1; margin-left: 8px;">
            <img src="${collector.avatar}" style="width: 36px; height: 36px; border-radius: 50%; object-fit: cover;">
            <div>
              <div style="font-weight: 700; font-size: 14px; color: var(--color-brand-dark); line-height: 1.2;">
                ${collector.name}
              </div>
              <div style="font-size: 11px; color: var(--color-primary); font-weight: 600;">
                Online • Calibrated Scale Equipped
              </div>
            </div>
          </div>
          <div class="top-bar-right">
            <button class="btn-icon btn-ghost" id="chat-phone-btn" data-col-id="${collector.id}">
              ${Icons.get('phone', { size: 20 })}
            </button>
          </div>
        </header>

        <!-- Messages Area -->
        <div class="chat-messages-scroll" id="chat-messages-container">
          <div style="text-align: center; margin: 8px 0;">
            <span style="font-size: 11px; background: #E2ECE9; color: var(--color-brand-dark); padding: 3px 10px; border-radius: 12px;">
              Today, Direct Encrypted Chat
            </span>
          </div>
          ${messagesHtml}
        </div>

        <!-- Action Quick-Pill Bar -->
        <div class="chat-action-pill-bar">
          <button class="chip" id="chat-share-pickup-btn" style="font-size: 12px; background: var(--color-primary-surface); color: var(--color-primary); border-color: var(--color-primary);">
            ${Icons.get('share', { size: 14 })} Share Pickup Details
          </button>
          <button class="chip" id="chat-quick-rate-btn" style="font-size: 12px;">
            What is your current rate?
          </button>
          <button class="chip" id="chat-quick-eta-btn" style="font-size: 12px;">
            What is your ETA?
          </button>
        </div>

        <!-- Composer Bar -->
        <div class="chat-composer-bar">
          <button class="btn-icon btn-ghost" id="chat-attach-cam-btn" title="Share Photo">
            ${Icons.get('camera', { size: 20 })}
          </button>
          <input type="text" id="chat-input" class="form-input" placeholder="Type message to collector..." style="padding: 10px 14px; border-radius: 20px;">
          <button class="btn-icon btn-primary" id="chat-send-btn" style="width: 40px; height: 40px;">
            ${Icons.get('chevron-right', { size: 18 })}
          </button>
        </div>
      </div>
    `;
  },

  // ==========================================
  // 9. CALL OVERLAY (SIMULATED)
  // ==========================================
  renderCall(collector) {
    const isConnected = state.state.activeCall && state.state.activeCall.status === 'connected';
    const duration = state.state.activeCall ? state.state.activeCall.duration : 0;
    const mins = String(Math.floor(duration / 60)).padStart(2, '0');
    const secs = String(duration % 60).padStart(2, '0');

    return `
      <div class="screen-call-overlay" id="screen-call">
        <div style="text-align: center;">
          <div style="font-size: 13px; font-weight: 700; color: var(--color-primary); letter-spacing: 0.05em; text-transform: uppercase;">
            ${isConnected ? 'Active ReCyclo Call' : 'Calling Collector…'}
          </div>
          <h2 style="font-family: var(--font-family-display); font-size: 26px; font-weight: 800; margin-top: 8px;">
            ${collector.name}
          </h2>
          <div style="font-size: 14px; opacity: 0.8; margin-top: 4px;" id="call-duration-text">
            ${isConnected ? `${mins}:${secs}` : 'Ringing…'}
          </div>
        </div>

        <div class="call-avatar-ring">
          <img src="${collector.avatar}" alt="${collector.name}" class="call-avatar-img">
        </div>

        <div class="call-controls-row">
          <div class="call-btn-circle mute" id="call-mute-btn" title="Mute">
            ${Icons.get('close', { size: 22 })}
          </div>
          <div class="call-btn-circle end-call" id="call-end-btn" title="End Call">
            ${Icons.get('phone', { size: 26 })}
          </div>
          <div class="call-btn-circle speaker" id="call-speaker-btn" title="Speaker">
            ${Icons.get('bell', { size: 22 })}
          </div>
        </div>
      </div>
    `;
  },

  // ==========================================
  // 10. SCHEDULE PICKUP
  // ==========================================
  renderSchedulePickup() {
    const draft = state.state.wasteDraft;
    const slots = ['09:00 AM', '11:00 AM', '02:00 PM', '04:00 PM'];

    const slotButtons = slots.map(slot => `
      <div class="time-slot-btn ${draft.pickupTimeSlot === slot ? 'selected' : ''}" data-slot="${slot}">
        ${slot}
      </div>
    `).join('');

    return `
      <div class="screen-view active-screen no-bottom-nav" id="screen-schedule-pickup" style="background: var(--color-bg-app); padding-bottom: 80px;">
        ${Components.renderTopBar({ title: 'Schedule Pickup', showBack: true })}

        <div style="padding: 16px;">
          <!-- Date Selection -->
          <div class="card" style="margin-bottom: 16px;">
            <h4 style="font-size: 15px; font-weight: 800; color: var(--color-brand-dark); margin-bottom: 12px;">
              Select Pickup Date
            </h4>
            <div style="display: flex; gap: 10px;">
              <button class="chip ${draft.pickupDate === 'Today' ? 'active' : ''}" data-date="Today" style="flex: 1; justify-content: center; padding: 10px;">
                Today
              </button>
              <button class="chip ${draft.pickupDate === 'Tomorrow' ? 'active' : ''}" data-date="Tomorrow" style="flex: 1; justify-content: center; padding: 10px;">
                Tomorrow
              </button>
              <button class="chip" data-date="Custom" style="flex: 1; justify-content: center; padding: 10px;">
                Pick Date
              </button>
            </div>
          </div>

          <!-- Time Slot Selection -->
          <div class="card" style="margin-bottom: 16px;">
            <h4 style="font-size: 15px; font-weight: 800; color: var(--color-brand-dark); margin-bottom: 4px;">
              Available Time Slots
            </h4>
            <p style="font-size: 12px; color: var(--color-text-secondary); margin-bottom: 12px;">
              Selected slot uses the primary ReCyclo branding
            </p>
            <div class="time-slots-grid">
              ${slotButtons}
            </div>
          </div>

          <!-- Pickup Address -->
          <div class="card" style="margin-bottom: 16px;">
            <h4 style="font-size: 15px; font-weight: 800; color: var(--color-brand-dark); margin-bottom: 8px;">
              Pickup Address
            </h4>
            <div style="display: flex; gap: 8px; align-items: flex-start;">
              <span style="color: var(--color-primary); margin-top: 2px;">${Icons.get('location', { size: 18, active: true })}</span>
              <span style="font-size: 13.5px; color: var(--color-brand-dark);">${draft.address}</span>
            </div>
          </div>
        </div>

        <div style="position: absolute; bottom: 0; left: 0; right: 0; background: #FFFFFF; border-top: 1px solid var(--color-border); padding: 12px 16px;">
          <button class="btn btn-primary btn-block btn-lg" id="schedule-confirm-btn">
            Proceed to Payment Selection
          </button>
        </div>
      </div>
    `;
  },

  // ==========================================
  // 11. PAYMENT SELECTION
  // ==========================================
  renderPayment() {
    const draft = state.state.wasteDraft;
    const estAmount = (draft.quantityKg * 18).toFixed(2);

    return `
      <div class="screen-view active-screen no-bottom-nav" id="screen-payment" style="background: var(--color-bg-app); padding-bottom: 80px;">
        ${Components.renderTopBar({ title: 'Payment Selection', showBack: true })}

        <div style="padding: 16px;">
          <!-- Amount Summary Card -->
          <div class="card" style="background: linear-gradient(135deg, var(--color-brand-dark) 0%, #007D67 100%); color: #FFFFFF; margin-bottom: 18px; padding: 18px;">
            <div style="font-size: 12px; opacity: 0.85; text-transform: uppercase; letter-spacing: 0.05em;">Estimated Payout to You</div>
            <div style="font-family: var(--font-family-display); font-size: 32px; font-weight: 800; margin: 4px 0;">
              ₹${estAmount}
            </div>
            <div style="font-size: 12px; opacity: 0.9;">
              Approx: ${draft.quantityKg} kg × ₹18.00/kg (${draft.category.toUpperCase()})
            </div>
            <div style="font-size: 11px; margin-top: 8px; opacity: 0.75;">
              *Final amount calculated at doorstep using digital scale.
            </div>
          </div>

          <h4 style="font-size: 15px; font-weight: 800; color: var(--color-brand-dark); margin-bottom: 12px;">
            Choose Payout Method
          </h4>

          <!-- Digital UPI -->
          <div class="payment-method-card ${draft.paymentMethod === 'UPI' ? 'selected' : ''}" data-method="UPI">
            <div style="display: flex; gap: 12px; align-items: center;">
              <div style="width: 42px; height: 42px; border-radius: var(--radius-md); background: var(--color-primary-light); color: var(--color-primary); display: flex; align-items: center; justify-content: center;">
                ${Icons.get('card', { size: 22, active: true })}
              </div>
              <div>
                <div style="font-weight: 700; font-size: 14px; color: var(--color-brand-dark);">Digital Payout (UPI / GPay / PhonePe)</div>
                <div style="font-size: 12px; color: var(--color-text-secondary);">Instant direct credit upon doorstep weighing</div>
              </div>
            </div>
            <div style="width: 20px; height: 20px; border-radius: 50%; border: 2px solid ${draft.paymentMethod === 'UPI' ? 'var(--color-primary)' : '#CBD5E1'}; display: flex; align-items: center; justify-content: center;">
              ${draft.paymentMethod === 'UPI' ? `<div style="width: 10px; height: 10px; border-radius: 50%; background: var(--color-primary);"></div>` : ''}
            </div>
          </div>

          <!-- Digital Card -->
          <div class="payment-method-card ${draft.paymentMethod === 'Card' ? 'selected' : ''}" data-method="Card">
            <div style="display: flex; gap: 12px; align-items: center;">
              <div style="width: 42px; height: 42px; border-radius: var(--radius-md); background: var(--color-primary-light); color: var(--color-primary); display: flex; align-items: center; justify-content: center;">
                ${Icons.get('credit-card', { size: 22, active: true })}
              </div>
              <div>
                <div style="font-weight: 700; font-size: 14px; color: var(--color-brand-dark);">Bank Account / Card Direct</div>
                <div style="font-size: 12px; color: var(--color-text-secondary);">IMPS/NEFT transfer to linked bank account</div>
              </div>
            </div>
            <div style="width: 20px; height: 20px; border-radius: 50%; border: 2px solid ${draft.paymentMethod === 'Card' ? 'var(--color-primary)' : '#CBD5E1'}; display: flex; align-items: center; justify-content: center;">
              ${draft.paymentMethod === 'Card' ? `<div style="width: 10px; height: 10px; border-radius: 50%; background: var(--color-primary);"></div>` : ''}
            </div>
          </div>

          <!-- Cash on Collection -->
          <div class="payment-method-card ${draft.paymentMethod === 'Cash' ? 'selected' : ''}" data-method="Cash">
            <div style="display: flex; gap: 12px; align-items: center;">
              <div style="width: 42px; height: 42px; border-radius: var(--radius-md); background: #FEF3C7; color: #D97706; display: flex; align-items: center; justify-content: center;">
                ${Icons.get('cash', { size: 22, active: true })}
              </div>
              <div>
                <div style="font-weight: 700; font-size: 14px; color: var(--color-brand-dark);">Cash on Collection</div>
                <div style="font-size: 12px; color: var(--color-text-secondary);">Collector pays exact cash during doorstep pickup</div>
              </div>
            </div>
            <div style="width: 20px; height: 20px; border-radius: 50%; border: 2px solid ${draft.paymentMethod === 'Cash' ? 'var(--color-primary)' : '#CBD5E1'}; display: flex; align-items: center; justify-content: center;">
              ${draft.paymentMethod === 'Cash' ? `<div style="width: 10px; height: 10px; border-radius: 50%; background: var(--color-primary);"></div>` : ''}
            </div>
          </div>
        </div>

        <div style="position: absolute; bottom: 0; left: 0; right: 0; background: #FFFFFF; border-top: 1px solid var(--color-border); padding: 12px 16px;">
          <button class="btn btn-primary btn-block btn-lg" id="payment-confirm-booking-btn">
            Confirm & Book Pickup
          </button>
        </div>
      </div>
    `;
  },

  // ==========================================
  // 12. REQUEST CONFIRMATION
  // ==========================================
  renderConfirmation() {
    const draft = state.state.wasteDraft;
    const estAmount = (draft.quantityKg * 18).toFixed(2);

    return `
      <div class="screen-view active-screen no-bottom-nav" id="screen-confirmation" style="background: #FFFFFF; padding: calc(var(--safe-area-top) + 24px) 20px 24px; text-align: center;">
        <div style="width: 76px; height: 76px; border-radius: 50%; background: var(--color-primary-light); color: var(--color-primary); display: flex; align-items: center; justify-content: center; margin: 0 auto 16px; box-shadow: 0 10px 24px rgba(0, 168, 132, 0.25);">
          ${Icons.get('check', { size: 40, active: true })}
        </div>

        <h2 style="font-family: var(--font-family-display); font-size: 24px; font-weight: 800; color: var(--color-brand-dark);">
          Pickup Request Confirmed!
        </h2>
        <p style="font-size: 13.5px; color: var(--color-text-secondary); margin-top: 4px;">
          Order ID: <strong>REQ-8492</strong> • Collector assigned
        </p>

        <!-- Structured Summary Card -->
        <div class="card" style="text-align: left; margin: 24px 0; padding: 16px; background: #F8FBFA; border: 1.5px solid var(--color-border);">
          <div style="display: flex; justify-content: space-between; padding-bottom: 10px; border-bottom: 1px solid var(--color-border-subtle); margin-bottom: 10px;">
            <span style="font-size: 12px; color: var(--color-text-muted);">Collector:</span>
            <span style="font-weight: 700; font-size: 13px; color: var(--color-brand-dark);">Rajesh Kumar</span>
          </div>
          <div style="display: flex; justify-content: space-between; padding-bottom: 10px; border-bottom: 1px solid var(--color-border-subtle); margin-bottom: 10px;">
            <span style="font-size: 12px; color: var(--color-text-muted);">Waste Category:</span>
            <span style="font-weight: 700; font-size: 13px; color: var(--color-brand-dark);">${draft.category.toUpperCase()} (${draft.quantityKg} kg)</span>
          </div>
          <div style="display: flex; justify-content: space-between; padding-bottom: 10px; border-bottom: 1px solid var(--color-border-subtle); margin-bottom: 10px;">
            <span style="font-size: 12px; color: var(--color-text-muted);">Date & Time:</span>
            <span style="font-weight: 700; font-size: 13px; color: var(--color-brand-dark);">${draft.pickupDate}, ${draft.pickupTimeSlot}</span>
          </div>
          <div style="display: flex; justify-content: space-between; padding-bottom: 10px; border-bottom: 1px solid var(--color-border-subtle); margin-bottom: 10px;">
            <span style="font-size: 12px; color: var(--color-text-muted);">Payout Method:</span>
            <span style="font-weight: 700; font-size: 13px; color: var(--color-primary);">${draft.paymentMethod} (Est. ₹${estAmount})</span>
          </div>
          <div style="display: flex; justify-content: space-between;">
            <span style="font-size: 12px; color: var(--color-text-muted);">Pickup Address:</span>
            <span style="font-weight: 600; font-size: 12px; color: var(--color-brand-dark); max-width: 180px; text-align: right;">${draft.address}</span>
          </div>
        </div>

        <div style="display: flex; flex-direction: column; gap: 10px;">
          <button class="btn btn-primary btn-block btn-lg" id="confirm-track-btn">
            Track Live Request
          </button>
          <button class="btn btn-secondary btn-block" id="confirm-chat-btn">
            ${Icons.get('chat', { size: 18 })} Message Collector
          </button>
          <button class="btn btn-ghost btn-block" id="confirm-home-btn" style="color: var(--color-text-secondary);">
            Back to Home
          </button>
        </div>
      </div>
    `;
  },

  // ==========================================
  // 13. LIVE REQUEST TRACKING
  // ==========================================
  renderLiveTracking() {
    const activeReq = state.state.activeRequest;
    const currentIdx = state.state.trackingStageIndex;

    const pipelineStepsHtml = activeReq.stages.map((stage, idx) => {
      const isCompleted = idx < currentIdx;
      const isCurrent = idx === currentIdx;
      const itemClass = isCompleted ? 'completed' : (isCurrent ? 'current' : '');

      let icon = Icons.get('check', { size: 14, active: true });
      if (isCurrent) {
        icon = `<span class="live-pulse-dot"></span>`;
      } else if (!isCompleted) {
        icon = `<span style="font-size: 11px;">${idx + 1}</span>`;
      }

      return `
        <div class="tracking-step-item ${itemClass}">
          ${idx < activeReq.stages.length - 1 ? `<div class="tracking-step-line"></div>` : ''}
          <div class="tracking-step-icon-bubble">
            ${icon}
          </div>
          <div style="flex: 1;">
            <div style="font-weight: 700; font-size: 14px; color: ${isCurrent ? 'var(--color-primary)' : 'var(--color-brand-dark)'};">
              ${stage.label}
            </div>
            <div style="font-size: 12px; color: var(--color-text-secondary); margin-top: 2px;">
              ${stage.time}
            </div>
          </div>
        </div>
      `;
    }).join('');

    return `
      <div class="screen-view active-screen no-bottom-nav" id="screen-live-tracking" style="background: var(--color-bg-app); padding-bottom: 80px;">
        ${Components.renderTopBar({ title: 'Live Request Tracking', showBack: true })}

        <div style="padding: 16px;">
          <!-- Collector Contact Card -->
          <div class="card" style="margin-bottom: 16px; padding: 14px;">
            <div style="display: flex; gap: 12px; align-items: center;">
              <img src="${activeReq.collectorAvatar}" style="width: 48px; height: 48px; border-radius: var(--radius-md); object-fit: cover;">
              <div style="flex: 1;">
                <div style="font-weight: 700; font-size: 15px; color: var(--color-brand-dark);">${activeReq.collectorName}</div>
                <div style="font-size: 12px; color: var(--color-text-secondary);">GreenCycle Partner • Calibrated Scale</div>
              </div>
              <button class="btn-icon btn-secondary" id="track-chat-btn" title="Chat">
                ${Icons.get('chat', { size: 18 })}
              </button>
              <button class="btn-icon btn-secondary" id="track-call-btn" title="Call">
                ${Icons.get('phone', { size: 18 })}
              </button>
            </div>
          </div>

          <!-- 6-Stage Timeline -->
          <div class="tracking-pipeline-container">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 18px;">
              <span style="font-size: 14px; font-weight: 800; color: var(--color-brand-dark);">Live Pipeline</span>
              <span class="badge badge-primary">ETA: ~12 mins</span>
            </div>
            ${pipelineStepsHtml}
          </div>

          <!-- Prototype Stage Simulator Control -->
          <div class="card" style="background: var(--color-primary-surface); border-color: rgba(0, 168, 132, 0.3); padding: 14px;">
            <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 8px;">
              <span style="font-size: 12px; font-weight: 700; color: var(--color-brand-dark);">Interactive Simulation Control</span>
              <span style="font-size: 11px; color: var(--color-primary); font-weight: 600;">Step ${currentIdx + 1} of 6</span>
            </div>
            <p style="font-size: 12px; color: var(--color-text-secondary); margin-bottom: 12px;">
              Advance through all 6 operational stages of doorstep collection.
            </p>
            <div style="display: flex; gap: 8px;">
              <button class="btn btn-primary btn-sm" id="tracking-next-stage-btn" style="flex: 1;">
                Advance Next Stage ❯
              </button>
              <button class="btn btn-outline btn-sm" id="tracking-reset-stage-btn">
                Reset
              </button>
            </div>
          </div>
        </div>

        <div style="position: absolute; bottom: 0; left: 0; right: 0; background: #FFFFFF; border-top: 1px solid var(--color-border); padding: 12px 16px;">
          ${currentIdx >= 4 ? `
            <button class="btn btn-primary btn-block btn-lg" id="tracking-rate-collector-btn">
              Rate Your Experience ★
            </button>
          ` : `
            <button class="btn btn-outline btn-block" id="tracking-home-btn">
              Return to Dashboard
            </button>
          `}
        </div>
      </div>
    `;
  },

  // ==========================================
  // 14. RATING & REVIEW
  // ==========================================
  renderRating() {
    return `
      <div class="screen-view active-screen no-bottom-nav" id="screen-rating" style="background: #FFFFFF; padding: calc(var(--safe-area-top) + 20px) 20px 24px; text-align: center;">
        <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&auto=format&fit=crop&q=80" style="width: 80px; height: 80px; border-radius: 50%; object-fit: cover; border: 3px solid var(--color-primary); margin: 0 auto 12px;">

        <h2 style="font-family: var(--font-family-display); font-size: 22px; font-weight: 800; color: var(--color-brand-dark);">
          How was your collection experience?
        </h2>
        <p style="font-size: 13.5px; color: var(--color-text-secondary); margin-top: 4px;">
          With Rajesh Kumar for REQ-8492
        </p>

        <!-- 1-5 Star Interactive Bar -->
        <div class="stars-rating-bar" id="rating-stars-bar">
          <span class="star-btn active" data-rating="1">★</span>
          <span class="star-btn active" data-rating="2">★</span>
          <span class="star-btn active" data-rating="3">★</span>
          <span class="star-btn active" data-rating="4">★</span>
          <span class="star-btn active" data-rating="5">★</span>
        </div>

        <div style="display: flex; gap: 8px; flex-wrap: wrap; justify-content: center; margin-bottom: 16px;">
          <button class="chip active" style="font-size: 12px;">Punctual</button>
          <button class="chip active" style="font-size: 12px;">Calibrated Scale</button>
          <button class="chip active" style="font-size: 12px;">Instant UPI</button>
          <button class="chip" style="font-size: 12px;">Polite & Helpful</button>
        </div>

        <div class="form-group" style="text-align: left;">
          <label class="form-label">Write an optional review</label>
          <textarea id="review-text-input" class="form-input" rows="3" style="resize: none;" placeholder="Share your experience to help the community...">Very quick collection and transparent weighing. Great experience!</textarea>
        </div>

        <button class="btn btn-primary btn-block btn-lg" id="submit-review-btn">
          Submit Review
        </button>
      </div>
    `;
  },

  // ==========================================
  // 15. MY REQUESTS
  // ==========================================
  renderRequests(tab = 'current') {
    const activeReq = state.state.activeRequest;
    const pastReqs = MockData.pastRequests;

    return `
      <div class="screen-view active-screen" id="screen-requests" style="background: var(--color-bg-app); padding-bottom: calc(var(--bottom-nav-height) + 16px);">
        ${Components.renderTopBar({ title: 'My Requests', showBell: true })}

        <div style="padding: 12px 16px; background: #FFFFFF; border-bottom: 1px solid var(--color-border-subtle);">
          <div class="segmented-control">
            <button class="segmented-option ${tab === 'current' ? 'active' : ''}" data-req-tab="current">
              Current Active
            </button>
            <button class="segmented-option ${tab === 'history' ? 'active' : ''}" data-req-tab="history">
              History
            </button>
          </div>
        </div>

        <div style="padding: 16px;">
          ${tab === 'current' ? `
            ${activeReq ? `
              <div class="card" style="margin-bottom: 14px; border-color: var(--color-primary); box-shadow: 0 4px 16px rgba(0,168,132,0.12);">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
                  <div style="display: flex; align-items: center; gap: 6px;">
                    <span class="live-pulse-dot"></span>
                    <span style="font-weight: 800; font-size: 13px; color: var(--color-brand-dark);">${activeReq.id}</span>
                  </div>
                  <span class="badge badge-primary">${activeReq.status.replace(/_/g, ' ').toUpperCase()}</span>
                </div>

                <div style="font-size: 15px; font-weight: 700; color: var(--color-brand-dark);">${activeReq.wasteType}</div>
                <div style="font-size: 13px; color: var(--color-text-secondary); margin: 4px 0;">
                  Quantity: <strong>${activeReq.quantity}</strong> • Scheduled: <strong>${activeReq.scheduledTime}</strong>
                </div>
                <div style="font-size: 12px; color: var(--color-text-muted); margin-bottom: 12px;">
                  Collector: ${activeReq.collectorName}
                </div>

                <div style="display: flex; gap: 10px;">
                  <button class="btn btn-primary btn-sm" id="req-card-track-btn" style="flex: 1;">
                    Track Live
                  </button>
                  <button class="btn btn-secondary btn-sm" id="req-card-chat-btn">
                    Message
                  </button>
                </div>
              </div>
            ` : Components.renderEmptyState({
                title: 'No active waste requests',
                desc: 'Schedule a collection to turn your household waste into cash!',
                buttonLabel: 'Add Waste',
                buttonAction: 'to-add-waste'
              })}
          ` : `
            ${pastReqs.map(r => `
              <div class="card" style="margin-bottom: 12px; padding: 14px;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 6px;">
                  <span style="font-weight: 700; font-size: 14px; color: var(--color-brand-dark);">${r.id}</span>
                  <span class="badge badge-available">Completed</span>
                </div>
                <div style="font-size: 14px; font-weight: 600; color: var(--color-brand-dark);">${r.wasteType} (${r.quantity})</div>
                <div style="display: flex; justify-content: space-between; align-items: center; font-size: 12px; color: var(--color-text-secondary); margin-top: 6px;">
                  <span>${r.date} • ${r.collector}</span>
                  <span style="font-weight: 800; color: var(--color-primary); font-size: 14px;">${r.amount}</span>
                </div>
              </div>
            `).join('')}
          `}
        </div>
      </div>

      ${Components.renderBottomNav('requests')}
    `;
  },

  // ==========================================
  // 16. COLLECTORS DIRECTORY
  // ==========================================
  renderCollectorsDirectory() {
    const collectors = MockData.collectors;
    const cardsHtml = collectors.map(col => Components.renderCollectorCard(col)).join('');

    return `
      <div class="screen-view active-screen" id="screen-collectors" style="background: var(--color-bg-app); padding-bottom: calc(var(--bottom-nav-height) + 16px);">
        ${Components.renderTopBar({ title: 'Waste Collectors', showBell: true })}

        <!-- Search Bar -->
        <div class="filter-sticky-header">
          <div class="input-wrapper search-input-box">
            <span class="input-icon-left">${Icons.get('search', { size: 18 })}</span>
            <input type="text" id="collectors-search-input" class="form-input has-icon-left" placeholder="Search collectors by name, area...">
          </div>

          <div style="display: flex; gap: 6px; overflow-x: auto; padding-bottom: 2px;">
            <button class="chip active" data-filter="all">All (4)</button>
            <button class="chip" data-filter="plastic">Plastic</button>
            <button class="chip" data-filter="paper">Paper</button>
            <button class="chip" data-filter="metal">Metal</button>
            <button class="chip" data-filter="e-waste">E-Waste</button>
            <button class="chip" data-filter="clothes">Clothes</button>
          </div>
        </div>

        <div style="padding: 16px;">
          <div class="collectors-stack" id="directory-collectors-list">
            ${cardsHtml}
          </div>
        </div>
      </div>

      ${Components.renderBottomNav('collectors')}
    `;
  },

  // ==========================================
  // 17. NOTIFICATIONS CENTER
  // ==========================================
  renderNotifications() {
    const notifs = state.state.notifications;

    const notifsHtml = notifs.map(n => `
      <div class="notification-item-card ${n.unread ? 'unread' : ''}" data-notif-action="${n.actionScreen}">
        <div style="width: 38px; height: 38px; border-radius: var(--radius-md); background: var(--color-primary-light); color: var(--color-primary); display: flex; align-items: center; justify-content: center; flex-shrink: 0;">
          ${Icons.get(n.type, { size: 18, active: true })}
        </div>
        <div style="flex: 1;">
          <div style="font-weight: 700; font-size: 13.5px; color: var(--color-brand-dark);">${n.title}</div>
          <p style="font-size: 12px; color: var(--color-text-secondary); margin-top: 2px; line-height: 1.4;">${n.desc}</p>
          <span style="font-size: 10px; color: var(--color-text-muted); display: block; margin-top: 4px;">${n.time}</span>
        </div>
      </div>
    `).join('');

    return `
      <div class="screen-view active-screen no-bottom-nav" id="screen-notifications" style="background: var(--color-bg-app);">
        ${Components.renderTopBar({ title: 'Notifications', showBack: true, showBell: false })}

        <div style="padding: 10px 16px; background: #FFFFFF; border-bottom: 1px solid var(--color-border-subtle); display: flex; justify-content: space-between; align-items: center;">
          <span style="font-size: 13px; color: var(--color-text-secondary);">Recent Alerts</span>
          <button class="btn-ghost" id="mark-notifs-read-btn" style="font-size: 12px; color: var(--color-primary); font-weight: 600; padding: 0;">
            Mark all read
          </button>
        </div>

        <div style="padding: 16px;">
          ${notifsHtml}
        </div>
      </div>
    `;
  },

  // ==========================================
  // 18. MESSAGES DIRECTORY
  // ==========================================
  renderMessages() {
    const collectors = MockData.collectors;

    return `
      <div class="screen-view active-screen no-bottom-nav" id="screen-messages" style="background: #FFFFFF;">
        ${Components.renderTopBar({ title: 'Messages', showBack: true, showBell: false })}

        <div>
          ${collectors.map(c => `
            <div class="message-thread-item" data-col-id="${c.id}">
              <div style="position: relative;">
                <img src="${c.avatar}" style="width: 46px; height: 46px; border-radius: 50%; object-fit: cover;">
                ${c.availability === 'available' ? `<span style="position: absolute; bottom: 0; right: 0; width: 12px; height: 12px; border-radius: 50%; background: #10B981; border: 2px solid #FFFFFF;"></span>` : ''}
              </div>
              <div style="flex: 1; min-width: 0;">
                <div style="display: flex; justify-content: space-between; align-items: center;">
                  <span style="font-weight: 700; font-size: 14px; color: var(--color-brand-dark);">${c.name}</span>
                  <span style="font-size: 11px; color: var(--color-text-muted);">01:49 PM</span>
                </div>
                <p style="font-size: 12px; color: var(--color-text-secondary); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; margin-top: 2px;">
                  ${c.id === 'col-1' ? 'ETA is around 12 minutes.' : 'Looking forward to the paper collection.'}
                </p>
              </div>
            </div>
          `).join('')}
        </div>
      </div>
    `;
  },

  // ==========================================
  // 19. PAYMENT HISTORY
  // ==========================================
  renderPaymentHistory() {
    const txns = MockData.paymentHistory;

    return `
      <div class="screen-view active-screen no-bottom-nav" id="screen-payment-history" style="background: var(--color-bg-app);">
        ${Components.renderTopBar({ title: 'Payment History', showBack: true })}

        <div style="padding: 16px;">
          <div class="card" style="background: linear-gradient(135deg, var(--color-brand-dark) 0%, #007D67 100%); color: #FFFFFF; margin-bottom: 18px; padding: 18px;">
            <div style="font-size: 12px; opacity: 0.85;">Total Earnings via ReCyclo</div>
            <div style="font-family: var(--font-family-display); font-size: 32px; font-weight: 800; margin: 4px 0;">₹975.00</div>
            <div style="font-size: 12px; opacity: 0.9;">14 successful doorstep payouts</div>
          </div>

          <h4 style="font-size: 15px; font-weight: 800; color: var(--color-brand-dark); margin-bottom: 12px;">
            Transactions
          </h4>

          ${txns.map(t => `
            <div class="card" style="margin-bottom: 10px; padding: 14px;">
              <div style="display: flex; justify-content: space-between; align-items: flex-start;">
                <div>
                  <div style="font-weight: 700; font-size: 14px; color: var(--color-brand-dark);">${t.wasteType}</div>
                  <div style="font-size: 12px; color: var(--color-text-secondary); margin-top: 2px;">${t.collector} • ${t.date}</div>
                  <div style="font-size: 11px; color: var(--color-text-muted); margin-top: 4px;">Ref: ${t.reference}</div>
                </div>
                <div style="text-align: right;">
                  <div style="font-family: var(--font-family-display); font-weight: 800; font-size: 16px; color: var(--color-primary);">${t.amount}</div>
                  <span class="badge badge-available" style="font-size: 10px; margin-top: 4px;">${t.method}</span>
                </div>
              </div>
            </div>
          `).join('')}
        </div>
      </div>
    `;
  },

  // ==========================================
  // 20. PROFILE SCREEN
  // ==========================================
  renderProfile() {
    const user = state.state.currentUser;

    return `
      <div class="screen-view active-screen" id="screen-profile" style="background: var(--color-bg-app); padding-bottom: calc(var(--bottom-nav-height) + 16px);">
        ${Components.renderTopBar({ title: 'My Profile', showBell: true })}

        <!-- Profile Hero -->
        <div style="background: #FFFFFF; padding: 20px 16px; border-bottom: 1px solid var(--color-border-subtle); display: flex; align-items: center; gap: 14px;">
          <img src="${user.avatar}" alt="${user.name}" style="width: 64px; height: 64px; border-radius: 50%; object-fit: cover; border: 2px solid var(--color-primary);">
          <div>
            <h2 style="font-family: var(--font-family-display); font-size: 18px; font-weight: 800; color: var(--color-brand-dark);">${user.name}</h2>
            <div style="font-size: 12.5px; color: var(--color-text-secondary);">${user.email}</div>
            <div style="font-size: 12px; color: var(--color-text-muted);">${user.phone}</div>
          </div>
        </div>

        <div style="padding: 16px;">
          <!-- Quick Nav List -->
          <div class="profile-menu-section">
            <div class="profile-menu-item" data-profile-to="requests">
              <div class="menu-item-left">
                <span style="color: var(--color-primary);">${Icons.get('requests', { size: 20 })}</span>
                <span>My Requests</span>
              </div>
              ${Icons.get('chevron-right', { size: 18 })}
            </div>
            <div class="profile-menu-item" data-profile-to="payments">
              <div class="menu-item-left">
                <span style="color: var(--color-primary);">${Icons.get('card', { size: 20 })}</span>
                <span>Payment History</span>
              </div>
              ${Icons.get('chevron-right', { size: 18 })}
            </div>
            <div class="profile-menu-item" data-profile-to="messages">
              <div class="menu-item-left">
                <span style="color: var(--color-primary);">${Icons.get('chat', { size: 20 })}</span>
                <span>Messages</span>
              </div>
              ${Icons.get('chevron-right', { size: 18 })}
            </div>
            <div class="profile-menu-item" data-profile-to="notifications">
              <div class="menu-item-left">
                <span style="color: var(--color-primary);">${Icons.get('bell', { size: 20 })}</span>
                <span>Notifications</span>
              </div>
              ${Icons.get('chevron-right', { size: 18 })}
            </div>
          </div>

          <!-- Settings & Help Section -->
          <div class="profile-menu-section">
            <div class="profile-menu-item" data-profile-to="settings">
              <div class="menu-item-left">
                <span style="color: var(--color-brand-dark);">${Icons.get('settings', { size: 20 })}</span>
                <span>Settings</span>
              </div>
              ${Icons.get('chevron-right', { size: 18 })}
            </div>
            <div class="profile-menu-item" data-profile-to="help">
              <div class="menu-item-left">
                <span style="color: var(--color-brand-dark);">${Icons.get('help', { size: 20 })}</span>
                <span>Help & Support / FAQs</span>
              </div>
              ${Icons.get('chevron-right', { size: 18 })}
            </div>
            <div class="profile-menu-item" data-profile-to="about">
              <div class="menu-item-left">
                <span style="color: var(--color-brand-dark);">${Icons.get('shield-check', { size: 20 })}</span>
                <span>About ReCyclo</span>
              </div>
              ${Icons.get('chevron-right', { size: 18 })}
            </div>
          </div>

          <!-- Logout Button -->
          <button class="btn btn-outline btn-block" id="profile-logout-btn" style="color: var(--color-danger); border-color: rgba(239, 68, 68, 0.3);">
            ${Icons.get('logout', { size: 18 })} Sign Out
          </button>
        </div>
      </div>

      ${Components.renderBottomNav('profile')}
    `;
  },

  // ==========================================
  // 21. SETTINGS
  // ==========================================
  renderSettings() {
    return `
      <div class="screen-view active-screen no-bottom-nav" id="screen-settings" style="background: var(--color-bg-app);">
        ${Components.renderTopBar({ title: 'Settings', showBack: true })}

        <div style="padding: 16px;">
          <div class="profile-menu-section">
            <div class="profile-menu-item">
              <div class="menu-item-left">
                <span>Push Notifications</span>
              </div>
              <input type="checkbox" checked style="accent-color: var(--color-primary); width: 18px; height: 18px;">
            </div>
            <div class="profile-menu-item">
              <div class="menu-item-left">
                <span>SMS Updates</span>
              </div>
              <input type="checkbox" checked style="accent-color: var(--color-primary); width: 18px; height: 18px;">
            </div>
            <div class="profile-menu-item">
              <div class="menu-item-left">
                <span>Location Services</span>
              </div>
              <span class="badge badge-available">Always On</span>
            </div>
          </div>

          <div class="profile-menu-section">
            <div class="profile-menu-item">
              <div class="menu-item-left">
                <span>Language</span>
              </div>
              <span style="font-size: 13px; color: var(--color-text-secondary);">English (India)</span>
            </div>
            <div class="profile-menu-item" id="settings-terms-link">
              <div class="menu-item-left">
                <span>Terms & Conditions</span>
              </div>
              ${Icons.get('chevron-right', { size: 18 })}
            </div>
            <div class="profile-menu-item" id="settings-privacy-link">
              <div class="menu-item-left">
                <span>Privacy Policy</span>
              </div>
              ${Icons.get('chevron-right', { size: 18 })}
            </div>
          </div>
        </div>
      </div>
    `;
  },

  // ==========================================
  // 22. HELP & SUPPORT / FAQS
  // ==========================================
  renderHelpSupport() {
    const faqs = MockData.faqs;

    const faqsHtml = faqs.map((f, i) => `
      <div class="card" style="margin-bottom: 10px; padding: 14px;">
        <div style="font-weight: 700; font-size: 14px; color: var(--color-brand-dark); display: flex; justify-content: space-between; align-items: center;">
          <span>${f.q}</span>
        </div>
        <p style="font-size: 13px; color: var(--color-text-secondary); margin-top: 8px; line-height: 1.5;">
          ${f.a}
        </p>
      </div>
    `).join('');

    return `
      <div class="screen-view active-screen no-bottom-nav" id="screen-help" style="background: var(--color-bg-app); padding-bottom: 24px;">
        ${Components.renderTopBar({ title: 'Help & Support', showBack: true })}

        <div style="padding: 16px;">
          <h4 style="font-size: 15px; font-weight: 800; color: var(--color-brand-dark); margin-bottom: 12px;">
            Frequently Asked Questions
          </h4>
          ${faqsHtml}

          <div class="card" style="background: var(--color-primary-surface); border-color: rgba(0, 168, 132, 0.3); padding: 16px; margin-top: 18px; text-align: center;">
            <h4 style="font-size: 15px; font-weight: 800; color: var(--color-brand-dark);">Need direct assistance?</h4>
            <p style="font-size: 12.5px; color: var(--color-text-secondary); margin: 6px 0 14px;">
              Our waste management specialists are available 7 days a week.
            </p>
            <button class="btn btn-primary btn-block" id="contact-support-btn">
              Contact Support
            </button>
          </div>
        </div>
      </div>
    `;
  },

  // ==========================================
  // 23. ABOUT RECYCLO
  // ==========================================
  renderAbout() {
    return `
      <div class="screen-view active-screen no-bottom-nav" id="screen-about" style="background: #FFFFFF; padding: calc(var(--safe-area-top) + 20px) 20px 30px; text-align: center;">
        <img src="assets/recyclo-logo.jpg" alt="ReCyclo Official Logo" style="width: 180px; margin: 0 auto 16px; border-radius: var(--radius-xl); box-shadow: var(--shadow-md);">

        <h2 style="font-family: var(--font-family-display); font-size: 24px; font-weight: 800; color: var(--color-brand-dark);">
          ReCyclo
        </h2>
        <div style="font-size: 13px; font-weight: 700; color: var(--color-primary); letter-spacing: 0.05em; text-transform: uppercase; margin-bottom: 16px;">
          Turning Waste into Worth.
        </div>

        <p style="font-size: 13.5px; color: var(--color-text-secondary); line-height: 1.6; text-align: left; margin-bottom: 16px;">
          ReCyclo connects environmentally conscious citizens directly with licensed, certified neighborhood waste collectors. By making recycling rewarding, transparent, and effortlessly accessible, we divert tons of recyclable materials from landfills every single day.
        </p>

        <div class="card" style="text-align: left; padding: 14px; background: #F8FBFA; margin-bottom: 20px;">
          <div style="font-size: 12px; color: var(--color-text-muted);">Version</div>
          <div style="font-weight: 700; font-size: 14px; color: var(--color-brand-dark);">2.4.0 (Production Mobile Edition)</div>
          <div style="font-size: 12px; color: var(--color-text-muted); margin-top: 8px;">Official Brand Identity</div>
          <div style="font-size: 12.5px; color: var(--color-brand-dark);">100% Brand Compliant • Emerald Teal & Marine Navy</div>
        </div>

        <button class="btn btn-outline btn-block" id="about-back-btn">
          Back
        </button>
      </div>
    `;
  }
};
