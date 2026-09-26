/**
 * ReCyclo Main Application Router & Event Controller
 * Drives screen transitions, global event delegations, and prototype simulations
 */

class App {
  constructor() {
    this.container = document.getElementById('app-screen-container');
    this.callOverlayContainer = document.getElementById('call-overlay-container');
    this.init();
  }

  init() {
    // Subscribe to state changes
    state.subscribe((currentState, eventKey, payload) => {
      this.handleStateChange(currentState, eventKey, payload);
    });

    // Setup global event delegation
    this.bindEvents();

    // Initial render
    this.renderCurrentScreen();

    // Auto-advance Splash Screen to Onboarding after 2.2 seconds
    setTimeout(() => {
      if (state.state.currentScreen === 'splash') {
        state.navigate('onboarding', { resetHistory: true });
      }
    }, 2200);

    // Dynamic Island time update
    this.startClock();
  }

  startClock() {
    const timeEl = document.getElementById('status-clock');
    if (!timeEl) return;
    const updateTime = () => {
      const now = new Date();
      timeEl.textContent = now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', hour12: false });
    };
    updateTime();
    setInterval(updateTime, 30000);
  }

  handleStateChange(currentState, eventKey, payload) {
    if (eventKey === 'navigate') {
      this.renderCurrentScreen();
    } else if (eventKey === 'callStarted' || eventKey === 'callConnected') {
      this.renderCallOverlay();
    } else if (eventKey === 'callTick') {
      this.updateCallDuration(payload);
    } else if (eventKey === 'callEnded') {
      this.removeCallOverlay();
    } else if (eventKey === 'chatMessageSent' || eventKey === 'chatMessageReceived') {
      this.refreshChatMessages();
    } else if (eventKey === 'trackingAdvanced') {
      if (currentState.currentScreen === 'live-tracking') {
        this.renderCurrentScreen();
      }
    } else if (eventKey === 'wasteDraftUpdate') {
      if (currentState.currentScreen === 'add-waste') {
        this.renderCurrentScreen();
      }
    }
  }

  renderCurrentScreen() {
    const s = state.state.currentScreen;
    let html = '';

    switch (s) {
      case 'splash':
        html = Screens.renderSplash();
        break;
      case 'onboarding':
        html = Screens.renderOnboarding(state.state.onboardingStep);
        break;
      case 'login':
        html = Screens.renderLogin();
        break;
      case 'signup':
        html = Screens.renderSignup();
        break;
      case 'home':
        html = Screens.renderHome();
        break;
      case 'add-waste':
        html = Screens.renderAddWaste(state.state.wasteDraft.step);
        break;
      case 'collector-matching':
        html = Screens.renderCollectorMatching();
        break;
      case 'collector-profile':
        html = Screens.renderCollectorProfile(state.state.selectedCollectorId);
        break;
      case 'chat':
        html = Screens.renderChat(state.state.selectedCollectorId);
        break;
      case 'schedule-pickup':
        html = Screens.renderSchedulePickup();
        break;
      case 'payment':
        html = Screens.renderPayment();
        break;
      case 'confirmation':
        html = Screens.renderConfirmation();
        break;
      case 'live-tracking':
        html = Screens.renderLiveTracking();
        break;
      case 'rating':
        html = Screens.renderRating();
        break;
      case 'requests':
        html = Screens.renderRequests('current');
        break;
      case 'collectors':
        html = Screens.renderCollectorsDirectory();
        break;
      case 'notifications':
        html = Screens.renderNotifications();
        break;
      case 'messages':
        html = Screens.renderMessages();
        break;
      case 'payment-history':
        html = Screens.renderPaymentHistory();
        break;
      case 'profile':
        html = Screens.renderProfile();
        break;
      case 'settings':
        html = Screens.renderSettings();
        break;
      case 'help':
        html = Screens.renderHelpSupport();
        break;
      case 'about':
        html = Screens.renderAbout();
        break;
      default:
        html = Screens.renderHome();
        break;
    }

    this.container.innerHTML = html;

    // Scroll active view to top
    const view = this.container.querySelector('.screen-view');
    if (view) view.scrollTop = 0;
  }

  // Live Call Screen Overlay
  renderCallOverlay() {
    if (!state.state.activeCall) return;
    this.callOverlayContainer.innerHTML = Screens.renderCall(state.state.activeCall.collector);
    this.callOverlayContainer.style.display = 'block';
  }

  updateCallDuration(sec) {
    const durEl = document.getElementById('call-duration-text');
    if (durEl) {
      const mins = String(Math.floor(sec / 60)).padStart(2, '0');
      const secs = String(sec % 60).padStart(2, '0');
      durEl.textContent = `${mins}:${secs}`;
    }
  }

  removeCallOverlay() {
    this.callOverlayContainer.innerHTML = '';
    this.callOverlayContainer.style.display = 'none';
  }

  refreshChatMessages() {
    const container = document.getElementById('chat-messages-container');
    if (!container) return;
    const messages = state.state.chatMessages;
    const collector = MockData.collectors.find(c => c.id === state.state.selectedCollectorId) || MockData.collectors[0];

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

    container.innerHTML = `
      <div style="text-align: center; margin: 8px 0;">
        <span style="font-size: 11px; background: #E2ECE9; color: var(--color-brand-dark); padding: 3px 10px; border-radius: 12px;">
          Today, Direct Encrypted Chat
        </span>
      </div>
      ${messagesHtml}
    `;
    container.scrollTop = container.scrollHeight;
  }

  // Global Event Binding
  bindEvents() {
    // 1. Navigation & App Bar Back button
    document.addEventListener('click', (e) => {
      // Topbar back
      if (e.target.closest('#topbar-back-btn') || e.target.closest('#chat-back-btn') || e.target.closest('#about-back-btn')) {
        state.goBack();
        return;
      }

      // Bell notification button
      if (e.target.closest('#home-bell-btn') || e.target.closest('#topbar-bell-btn')) {
        state.navigate('notifications');
        return;
      }

      // Bottom Navigation items
      const navItem = e.target.closest('.nav-item');
      if (navItem && navItem.dataset.nav) {
        const targetNav = navItem.dataset.nav;
        if (targetNav === 'add-waste') {
          state.setWasteDraft({ step: 1 });
        }
        state.navigate(targetNav, { tab: targetNav });
        return;
      }

      // Onboarding
      if (e.target.closest('#onboarding-skip-btn')) {
        state.navigate('login', { resetHistory: true });
        return;
      }
      if (e.target.closest('#onboarding-next-btn')) {
        state.state.onboardingStep = 2;
        this.renderCurrentScreen();
        return;
      }
      if (e.target.closest('#onboarding-start-btn')) {
        state.navigate('login', { resetHistory: true });
        return;
      }

      // Auth transitions
      if (e.target.closest('#to-signup-btn')) {
        state.navigate('signup');
        return;
      }
      if (e.target.closest('#to-login-btn')) {
        state.navigate('login');
        return;
      }
      if (e.target.closest('#google-login-btn')) {
        Components.showToast('Signed in securely with Google Account', 'success');
        state.navigate('home', { resetHistory: true });
        return;
      }
      if (e.target.closest('#forgot-password-btn')) {
        Components.showToast('Password reset link sent to your email', 'info');
        return;
      }

      // Home Screen Actions
      if (e.target.closest('#home-add-waste-btn') || e.target.closest('#home-hero-cta')) {
        state.setWasteDraft({ step: 1 });
        state.navigate('add-waste');
        return;
      }

      const quickAction = e.target.closest('.quick-action-item');
      if (quickAction) {
        const act = quickAction.dataset.action;
        if (act === 'quick-add') {
          state.setWasteDraft({ step: 1 });
          state.navigate('add-waste');
        } else if (act === 'quick-collectors') {
          state.navigate('collectors');
        } else if (act === 'quick-requests') {
          state.navigate('requests');
        } else if (act === 'quick-payments') {
          state.navigate('payment-history');
        }
        return;
      }

      if (e.target.closest('#home-track-active-btn') || e.target.closest('#home-active-request-card')) {
        state.navigate('live-tracking');
        return;
      }

      if (e.target.closest('#home-view-categories-btn')) {
        state.setWasteDraft({ step: 2 });
        state.navigate('add-waste');
        return;
      }

      if (e.target.closest('#home-view-collectors-btn')) {
        state.navigate('collectors');
        return;
      }

      // Category Pill Click
      const catPill = e.target.closest('.category-pill-card');
      if (catPill && catPill.dataset.categoryId) {
        state.setWasteDraft({ category: catPill.dataset.categoryId, step: 2 });
        state.navigate('add-waste');
        return;
      }

      // Collector Card Buttons
      const colProfBtn = e.target.closest('.collector-profile-btn');
      if (colProfBtn && colProfBtn.dataset.collectorId) {
        state.state.selectedCollectorId = colProfBtn.dataset.collectorId;
        state.navigate('collector-profile');
        return;
      }

      const colChatBtn = e.target.closest('.collector-chat-btn') || e.target.closest('#profile-chat-btn');
      if (colChatBtn) {
        const id = colChatBtn.dataset.collectorId || colChatBtn.dataset.colId;
        if (id) state.state.selectedCollectorId = id;
        state.navigate('chat');
        return;
      }

      const colCallBtn = e.target.closest('.collector-call-btn') || e.target.closest('#profile-call-btn') || e.target.closest('#chat-phone-btn');
      if (colCallBtn) {
        const id = colCallBtn.dataset.collectorId || colCallBtn.dataset.colId || state.state.selectedCollectorId;
        const col = MockData.collectors.find(c => c.id === id) || MockData.collectors[0];
        state.startCall(col);
        return;
      }

      const colBookBtn = e.target.closest('.collector-book-btn') || e.target.closest('#profile-schedule-btn');
      if (colBookBtn) {
        const id = colBookBtn.dataset.collectorId || colBookBtn.dataset.colId || state.state.selectedCollectorId;
        state.state.selectedCollectorId = id;
        state.navigate('schedule-pickup');
        return;
      }

      // Add Waste Flow Steps
      if (e.target.closest('#camera-trigger-box') || e.target.closest('#waste-camera-sample-btn') || e.target.closest('#waste-gallery-sample-btn')) {
        // Sample realistic clean recyclable waste photo
        state.setWasteDraft({
          photoUrl: 'https://images.unsplash.com/photo-1532996122724-e3c354a0b15b?w=600&auto=format&fit=crop&q=80',
          suggestedCategory: 'Plastic & PET Bottles (Suggested)'
        });
        Components.showToast('Waste photo added successfully! Suggested: Plastic', 'success');
        return;
      }

      if (e.target.closest('#waste-retake-photo-btn')) {
        state.setWasteDraft({ photoUrl: null });
        return;
      }

      if (e.target.closest('#waste-remove-photo-btn')) {
        state.setWasteDraft({ photoUrl: null });
        Components.showToast('Photo removed', 'info');
        return;
      }

      if (e.target.closest('#add-waste-next-1')) {
        state.setWasteDraft({ step: 2 });
        return;
      }

      // Step 2: Category select card
      const catCard = e.target.closest('.category-select-card');
      if (catCard && catCard.dataset.catId) {
        state.setWasteDraft({ category: catCard.dataset.catId });
        return;
      }

      if (e.target.closest('#add-waste-next-2')) {
        state.setWasteDraft({ step: 3 });
        return;
      }

      // Step 3: Quantity +/- & Presets
      if (e.target.closest('#qty-plus')) {
        const newQty = Math.min(200, state.state.wasteDraft.quantityKg + 0.5);
        state.setWasteDraft({ quantityKg: newQty });
        return;
      }

      if (e.target.closest('#qty-minus')) {
        const newQty = Math.max(1, state.state.wasteDraft.quantityKg - 0.5);
        state.setWasteDraft({ quantityKg: newQty });
        return;
      }

      const qtyPreset = e.target.closest('.preset-pills-row .chip');
      if (qtyPreset && qtyPreset.dataset.qty) {
        state.setWasteDraft({ quantityKg: parseFloat(qtyPreset.dataset.qty) });
        return;
      }

      if (e.target.closest('#add-waste-next-3')) {
        state.setWasteDraft({ step: 4 });
        return;
      }

      if (e.target.closest('#add-waste-next-4')) {
        const notesInput = document.getElementById('waste-notes-input');
        if (notesInput) {
          state.setWasteDraft({ notes: notesInput.value });
        }
        state.setWasteDraft({ step: 5 });
        return;
      }

      if (e.target.closest('#add-waste-prev')) {
        const cur = state.state.wasteDraft.step;
        if (cur > 1) {
          state.setWasteDraft({ step: cur - 1 });
        } else {
          state.goBack();
        }
        return;
      }

      // Step 5: Find Collectors with Skeleton Loading Transition
      if (e.target.closest('#add-waste-find-collectors-btn')) {
        const btn = document.getElementById('add-waste-find-collectors-btn');
        if (btn) btn.classList.add('is-loading');

        setTimeout(() => {
          state.navigate('collector-matching');
          Components.showToast('Found 4 available neighborhood collectors!', 'success');
        }, 600);
        return;
      }

      // Schedule Pickup
      const slotBtn = e.target.closest('.time-slot-btn');
      if (slotBtn && slotBtn.dataset.slot) {
        state.setWasteDraft({ pickupTimeSlot: slotBtn.dataset.slot });
        document.querySelectorAll('.time-slot-btn').forEach(b => b.classList.remove('selected'));
        slotBtn.classList.add('selected');
        return;
      }

      const dateBtn = e.target.closest('[data-date]');
      if (dateBtn && dateBtn.dataset.date) {
        state.setWasteDraft({ pickupDate: dateBtn.dataset.date });
        document.querySelectorAll('[data-date]').forEach(b => b.classList.remove('active'));
        dateBtn.classList.add('active');
        return;
      }

      if (e.target.closest('#schedule-confirm-btn')) {
        state.navigate('payment');
        return;
      }

      // Payment Selection
      const payCard = e.target.closest('.payment-method-card');
      if (payCard && payCard.dataset.method) {
        state.setWasteDraft({ paymentMethod: payCard.dataset.method });
        document.querySelectorAll('.payment-method-card').forEach(c => c.classList.remove('selected'));
        payCard.classList.add('selected');
        return;
      }

      if (e.target.closest('#payment-confirm-booking-btn')) {
        const btn = document.getElementById('payment-confirm-booking-btn');
        if (btn) btn.classList.add('is-loading');

        setTimeout(() => {
          state.navigate('confirmation');
          Components.showToast('Pickup successfully booked with Rajesh Kumar!', 'success');
        }, 700);
        return;
      }

      // Confirmation Actions
      if (e.target.closest('#confirm-track-btn')) {
        state.navigate('live-tracking');
        return;
      }
      if (e.target.closest('#confirm-chat-btn')) {
        state.navigate('chat');
        return;
      }
      if (e.target.closest('#confirm-home-btn')) {
        state.navigate('home', { resetHistory: true });
        return;
      }

      // Live Tracking Simulator Controls
      if (e.target.closest('#tracking-next-stage-btn')) {
        state.advanceTrackingStage();
        const stageLabels = ['Request Placed', 'Collector Accepted', 'Pickup Scheduled', 'Collector On The Way', 'Waste Collected', 'Payment Completed'];
        const label = stageLabels[state.state.trackingStageIndex];
        Components.showToast(`Stage updated: ${label}`, 'success');
        return;
      }

      if (e.target.closest('#tracking-reset-stage-btn')) {
        state.resetTrackingStage();
        Components.showToast('Tracking reset to Request Placed', 'info');
        return;
      }

      if (e.target.closest('#tracking-rate-collector-btn')) {
        state.navigate('rating');
        return;
      }

      if (e.target.closest('#tracking-home-btn')) {
        state.navigate('home', { resetHistory: true });
        return;
      }

      if (e.target.closest('#track-chat-btn')) {
        state.navigate('chat');
        return;
      }
      if (e.target.closest('#track-call-btn')) {
        state.startCall(MockData.collectors[0]);
        return;
      }

      // Rating Screen
      const star = e.target.closest('.star-btn');
      if (star && star.dataset.rating) {
        const ratingVal = parseInt(star.dataset.rating);
        document.querySelectorAll('.star-btn').forEach((s, idx) => {
          if (idx < ratingVal) s.classList.add('active');
          else s.classList.remove('active');
        });
        return;
      }

      if (e.target.closest('#submit-review-btn')) {
        Components.showToast('Thank you for your feedback!', 'success');
        setTimeout(() => {
          state.navigate('home', { resetHistory: true });
        }, 800);
        return;
      }

      // Requests tab switch
      const reqTab = e.target.closest('[data-req-tab]');
      if (reqTab && reqTab.dataset.reqTab) {
        this.container.innerHTML = Screens.renderRequests(reqTab.dataset.reqTab);
        return;
      }

      if (e.target.closest('#req-card-track-btn')) {
        state.navigate('live-tracking');
        return;
      }
      if (e.target.closest('#req-card-chat-btn')) {
        state.navigate('chat');
        return;
      }

      // Chat controls
      if (e.target.closest('#chat-send-btn')) {
        const input = document.getElementById('chat-input');
        if (input && input.value.trim()) {
          state.sendChatMessage(input.value.trim());
          input.value = '';
        }
        return;
      }

      if (e.target.closest('#chat-share-pickup-btn')) {
        state.sendChatMessage('', true);
        return;
      }

      if (e.target.closest('#chat-quick-rate-btn')) {
        state.sendChatMessage('What is your current rate for this waste?');
        return;
      }

      if (e.target.closest('#chat-quick-eta-btn')) {
        state.sendChatMessage('What is your current ETA?');
        return;
      }

      if (e.target.closest('#chat-attach-cam-btn')) {
        state.sendChatMessage('Attached: 2 bags of segregated plastic ready at door.');
        Components.showToast('Simulated waste photo shared in chat', 'info');
        return;
      }

      // Call Overlay Controls
      if (e.target.closest('#call-end-btn')) {
        state.endCall();
        Components.showToast('Call ended', 'info');
        return;
      }
      if (e.target.closest('#call-mute-btn')) {
        const muteBtn = document.getElementById('call-mute-btn');
        if (muteBtn) muteBtn.classList.toggle('active');
        Components.showToast('Microphone toggled', 'info');
        return;
      }
      if (e.target.closest('#call-speaker-btn')) {
        const speakerBtn = document.getElementById('call-speaker-btn');
        if (speakerBtn) speakerBtn.classList.toggle('active');
        Components.showToast('Speaker toggled', 'info');
        return;
      }

      // Directory Filters
      const dirFilter = e.target.closest('#screen-collectors .chip');
      if (dirFilter && dirFilter.dataset.filter) {
        document.querySelectorAll('#screen-collectors .chip').forEach(c => c.classList.remove('active'));
        dirFilter.classList.add('active');
        const filter = dirFilter.dataset.filter;

        const listContainer = document.getElementById('directory-collectors-list');
        if (listContainer) {
          const filtered = filter === 'all' 
            ? MockData.collectors 
            : MockData.collectors.filter(c => c.acceptedCategories.includes(filter));

          if (filtered.length === 0) {
            listContainer.innerHTML = Components.renderEmptyState({
              title: 'No collectors found for this filter',
              desc: 'Try selecting another waste category or broadening your search.',
              buttonLabel: 'Show All Collectors',
              buttonAction: 'reset-collector-filter'
            });
          } else {
            listContainer.innerHTML = filtered.map(c => Components.renderCollectorCard(c)).join('');
          }
        }
        return;
      }

      // Notifications
      const notifItem = e.target.closest('.notification-item-card');
      if (notifItem && notifItem.dataset.notifAction) {
        const act = notifItem.dataset.notifAction;
        if (act === 'tracking') state.navigate('live-tracking');
        else if (act === 'payment-history') state.navigate('payment-history');
        else if (act === 'rating') state.navigate('rating');
        return;
      }

      if (e.target.closest('#mark-notifs-read-btn')) {
        state.markAllNotificationsRead();
        this.renderCurrentScreen();
        Components.showToast('All notifications marked as read', 'success');
        return;
      }

      // Messages item click
      const msgItem = e.target.closest('.message-thread-item');
      if (msgItem && msgItem.dataset.colId) {
        state.state.selectedCollectorId = msgItem.dataset.colId;
        state.navigate('chat');
        return;
      }

      // Profile Links
      const profLink = e.target.closest('[data-profile-to]');
      if (profLink && profLink.dataset.profileTo) {
        const target = profLink.dataset.profileTo;
        if (target === 'requests') state.navigate('requests');
        else if (target === 'payments') state.navigate('payment-history');
        else if (target === 'messages') state.navigate('messages');
        else if (target === 'notifications') state.navigate('notifications');
        else if (target === 'settings') state.navigate('settings');
        else if (target === 'help') state.navigate('help');
        else if (target === 'about') state.navigate('about');
        return;
      }

      if (e.target.closest('#profile-logout-btn')) {
        state.navigate('login', { resetHistory: true });
        Components.showToast('Signed out successfully', 'info');
        return;
      }

      if (e.target.closest('#contact-support-btn')) {
        Components.showToast('Support ticket #ECO-912 raised. We will contact you shortly.', 'success');
        return;
      }

      if (e.target.closest('[data-action="to-add-waste"]')) {
        state.setWasteDraft({ step: 1 });
        state.navigate('add-waste');
        return;
      }

      if (e.target.closest('[data-action="reset-collector-filter"]')) {
        state.navigate('collectors');
        return;
      }

      // Bottom Sheet backdrop click
      if (e.target.id === 'sheet-backdrop' || e.target.closest('#sheet-close-btn')) {
        Components.closeBottomSheet();
        return;
      }
    });

    // Form Submissions
    document.addEventListener('submit', (e) => {
      e.preventDefault();

      if (e.target.id === 'login-form') {
        const ident = document.getElementById('login-identifier');
        const pass = document.getElementById('login-password');
        let valid = true;

        if (!ident || !ident.value.trim()) {
          document.getElementById('login-identifier-error').style.display = 'block';
          valid = false;
        } else {
          document.getElementById('login-identifier-error').style.display = 'none';
        }

        if (!pass || pass.value.length < 6) {
          document.getElementById('login-password-error').style.display = 'block';
          valid = false;
        } else {
          document.getElementById('login-password-error').style.display = 'none';
        }

        if (valid) {
          Components.showToast('Welcome back, Alex!', 'success');
          state.navigate('home', { resetHistory: true });
        }
        return;
      }

      if (e.target.id === 'signup-form') {
        const name = document.getElementById('signup-name');
        const email = document.getElementById('signup-email');
        const pass = document.getElementById('signup-password');
        const confirmPass = document.getElementById('signup-confirm-password');

        if (pass.value !== confirmPass.value) {
          Components.showToast('Passwords do not match', 'error');
          return;
        }

        Components.showToast('Account created successfully!', 'success');
        state.navigate('home', { resetHistory: true });
        return;
      }
    });

    // Chat enter key
    document.addEventListener('keydown', (e) => {
      if (e.key === 'Enter' && e.target.id === 'chat-input') {
        e.preventDefault();
        const input = e.target;
        if (input.value.trim()) {
          state.sendChatMessage(input.value.trim());
          input.value = '';
        }
      }
    });

    // Directory live search input
    document.addEventListener('input', (e) => {
      if (e.target.id === 'collectors-search-input') {
        const query = e.target.value.toLowerCase().trim();
        const listContainer = document.getElementById('directory-collectors-list');
        if (!listContainer) return;

        const filtered = MockData.collectors.filter(c => 
          c.name.toLowerCase().includes(query) ||
          c.serviceArea.toLowerCase().includes(query) ||
          c.agency.toLowerCase().includes(query)
        );

        if (filtered.length === 0) {
          listContainer.innerHTML = Components.renderEmptyState({
            title: 'No matching collectors found',
            desc: `No collectors match "${e.target.value}". Try a different search term.`,
            buttonLabel: 'Clear Search',
            buttonAction: 'reset-collector-filter'
          });
        } else {
          listContainer.innerHTML = filtered.map(c => Components.renderCollectorCard(c)).join('');
        }
      }
    });
  }
}

// Instantiate on DOM ready
document.addEventListener('DOMContentLoaded', () => {
  window.recycloApp = new App();
});
