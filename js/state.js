/**
 * ReCyclo Reactive App State Management
 * Handles navigation, interactive forms, real-time stage progression, and user sessions
 */

class AppState {
  constructor() {
    this.state = {
      currentScreen: 'splash',
      screenHistory: [],
      activeBottomTab: 'home',
      onboardingStep: 1,
      isAuthenticated: true, // starts logged in for demo or can toggle
      currentUser: { ...MockData.currentUser },
      
      // Add Waste Draft
      wasteDraft: {
        step: 1, // 1: Photo, 2: Category, 3: Quantity, 4: Notes, 5: Location
        photoUrl: null,
        category: 'plastic',
        suggestedCategory: 'Plastic Bottles (suggested)',
        quantityKg: 8.5,
        notes: 'Dry cardboard and clean PET plastic bottles.',
        address: MockData.currentUser.savedAddresses[0].address,
        pickupDate: 'Today',
        pickupTimeSlot: '02:00 PM',
        paymentMethod: 'UPI'
      },

      // Directory & Selection
      selectedCollectorId: 'col-1',
      activeFilterCategory: 'all',
      searchQuery: '',
      collectorFilterAvailability: 'all',

      // Active Request & Live Tracking
      activeRequest: JSON.parse(JSON.stringify(MockData.activeRequest)),
      trackingStageIndex: 3, // 0: placed, 1: accepted, 2: scheduled, 3: on_the_way, 4: collected, 5: completed

      // Chat & Call
      chatMessages: [...MockData.chatHistory],
      activeCall: null,

      // Notifications & Reviews
      notifications: [...MockData.notifications],
      unreadNotificationCount: 2,
      lastRatingSubmission: null
    };

    this.listeners = [];
  }

  // Subscribe to state updates
  subscribe(callback) {
    this.listeners.push(callback);
    return () => {
      this.listeners = this.listeners.filter(cb => cb !== callback);
    };
  }

  notify(eventKey, payload) {
    this.listeners.forEach(cb => cb(this.state, eventKey, payload));
  }

  // Screen Navigation
  navigate(screenName, { addToHistory = true, resetHistory = false, tab = null } = {}) {
    if (this.state.currentScreen === screenName) return;

    if (resetHistory) {
      this.state.screenHistory = [];
    } else if (addToHistory && this.state.currentScreen) {
      this.state.screenHistory.push(this.state.currentScreen);
    }

    this.state.currentScreen = screenName;

    // Update bottom navigation active tab if relevant
    if (tab) {
      this.state.activeBottomTab = tab;
    } else if (['home', 'requests', 'add-waste', 'collectors', 'profile'].includes(screenName)) {
      this.state.activeBottomTab = screenName;
    }

    this.notify('navigate', screenName);
  }

  goBack() {
    if (this.state.screenHistory.length > 0) {
      const prevScreen = this.state.screenHistory.pop();
      this.state.currentScreen = prevScreen;
      
      if (['home', 'requests', 'add-waste', 'collectors', 'profile'].includes(prevScreen)) {
        this.state.activeBottomTab = prevScreen;
      }
      this.notify('navigate', prevScreen);
      return true;
    } else {
      this.navigate('home', { resetHistory: true });
      return false;
    }
  }

  // Waste Submission Draft
  setWasteDraft(updates) {
    this.state.wasteDraft = { ...this.state.wasteDraft, ...updates };
    this.notify('wasteDraftUpdate', this.state.wasteDraft);
  }

  resetWasteDraft() {
    this.state.wasteDraft = {
      step: 1,
      photoUrl: null,
      category: 'plastic',
      suggestedCategory: 'Plastic Bottles (suggested)',
      quantityKg: 8.5,
      notes: '',
      address: this.state.currentUser.savedAddresses[0].address,
      pickupDate: 'Today',
      pickupTimeSlot: '02:00 PM',
      paymentMethod: 'UPI'
    };
    this.notify('wasteDraftUpdate', this.state.wasteDraft);
  }

  // Live Tracking Stage Progression (Simulated)
  advanceTrackingStage() {
    const stages = this.state.activeRequest.stages;
    if (this.state.trackingStageIndex < stages.length - 1) {
      this.state.trackingStageIndex += 1;
      
      // Update stages in activeRequest
      stages.forEach((stage, idx) => {
        stage.done = idx <= this.state.trackingStageIndex;
        stage.current = idx === this.state.trackingStageIndex;
        if (idx === this.state.trackingStageIndex && stage.time === 'Pending') {
          const now = new Date();
          stage.time = now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
        }
      });

      this.state.activeRequest.status = stages[this.state.trackingStageIndex].key;
      this.notify('trackingAdvanced', this.state.trackingStageIndex);
    }
  }

  resetTrackingStage() {
    this.state.trackingStageIndex = 0;
    this.state.activeRequest.stages.forEach((stage, idx) => {
      stage.done = idx === 0;
      stage.current = idx === 0;
    });
    this.state.activeRequest.status = 'placed';
    this.notify('trackingAdvanced', 0);
  }

  // Chat System
  sendChatMessage(text, isPickupSummary = false) {
    if (!text && !isPickupSummary) return;

    const newMsg = {
      id: 'm_' + Date.now(),
      sender: 'user',
      text: text,
      isPickupSummary: isPickupSummary,
      time: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
    };

    this.state.chatMessages.push(newMsg);
    this.notify('chatMessageSent', newMsg);

    // Realistic auto-reply simulation
    setTimeout(() => {
      let replyText = 'Understood! I will be there as scheduled. Feel free to call if any updates.';
      if (isPickupSummary) {
        replyText = 'Pickup summary received and locked into my schedule! See you at ' + this.state.wasteDraft.pickupTimeSlot + '.';
      } else if (text.toLowerCase().includes('price') || text.toLowerCase().includes('rate')) {
        replyText = 'Yes! For plastic we pay ₹18/kg and for paper ₹14/kg based on calibrated digital scale reading.';
      } else if (text.toLowerCase().includes('delay') || text.toLowerCase().includes('where')) {
        replyText = 'I am currently 5 minutes away, just turning onto your main street!';
      }

      const replyMsg = {
        id: 'm_' + Date.now(),
        sender: 'collector',
        text: replyText,
        time: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
      };
      this.state.chatMessages.push(replyMsg);
      this.notify('chatMessageReceived', replyMsg);
    }, 1200);
  }

  // In-app Call Simulation
  startCall(collector) {
    this.state.activeCall = {
      collector: collector,
      status: 'calling', // calling -> connected
      duration: 0,
      isMuted: false,
      isSpeaker: false,
      timerId: null
    };
    this.notify('callStarted', this.state.activeCall);

    // Transition to connected after 2.5 seconds
    setTimeout(() => {
      if (this.state.activeCall && this.state.activeCall.status === 'calling') {
        this.state.activeCall.status = 'connected';
        this.state.activeCall.timerId = setInterval(() => {
          if (this.state.activeCall) {
            this.state.activeCall.duration += 1;
            this.notify('callTick', this.state.activeCall.duration);
          }
        }, 1000);
        this.notify('callConnected', this.state.activeCall);
      }
    }, 2400);
  }

  endCall() {
    if (this.state.activeCall) {
      if (this.state.activeCall.timerId) {
        clearInterval(this.state.activeCall.timerId);
      }
      this.state.activeCall = null;
      this.notify('callEnded');
    }
  }

  // Notifications
  markAllNotificationsRead() {
    this.state.notifications.forEach(n => n.unread = false);
    this.state.unreadNotificationCount = 0;
    this.notify('notificationsRead');
  }
}

// Global state instance
const state = new AppState();
