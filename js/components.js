/**
 * ReCyclo Dynamic Component Builders
 * Produces accessible, modular UI components matching exact brand identity
 */

const Components = {
  // Top App Bar
  renderTopBar({ title = '', showBack = false, showBell = true, showLogo = false } = {}) {
    const leftContent = showBack
      ? `<button class="btn-icon btn-ghost" id="topbar-back-btn" aria-label="Go back">
           ${Icons.get('chevron-left', { size: 22 })}
         </button>`
      : (showLogo 
          ? `<div style="display: flex; align-items: center; gap: 8px;">
               <img src="assets/recyclo-logo.jpg" alt="ReCyclo Logo" style="height: 34px; width: 34px; object-fit: contain; border-radius: 8px; box-shadow: var(--shadow-xs);">
               <span style="font-family: var(--font-family-display); font-weight: 800; font-size: 19px; color: var(--color-brand-dark); letter-spacing: -0.02em;">Re<span style="color: var(--color-primary);">Cyclo</span></span>
             </div>`
          : `<div style="width: 36px;"></div>`);

    const rightContent = showBell
      ? `<button class="notification-bell-btn" id="topbar-bell-btn" aria-label="Notifications">
           ${Icons.get('bell', { size: 20 })}
           ${state.state.unreadNotificationCount > 0 ? `<span class="unread-badge-pill"></span>` : ''}
         </button>`
      : `<div style="width: 36px;"></div>`;

    return `
      <header class="top-bar">
        <div class="top-bar-left">${leftContent}</div>
        <div class="top-bar-title">${title}</div>
        <div class="top-bar-right">${rightContent}</div>
      </header>
    `;
  },

  // Bottom Navigation Bar with dual-state outline/filled icons & elevated Add Waste button
  renderBottomNav(activeTab = 'home') {
    return `
      <nav class="bottom-nav-container" aria-label="Main Navigation">
        <!-- Home -->
        <div class="nav-item ${activeTab === 'home' ? 'active' : ''}" data-nav="home" role="button" tabindex="0">
          <div class="nav-icon">
            ${Icons.get('home', { active: activeTab === 'home', size: 24 })}
          </div>
          <span class="nav-label">Home</span>
        </div>

        <!-- Requests -->
        <div class="nav-item ${activeTab === 'requests' ? 'active' : ''}" data-nav="requests" role="button" tabindex="0">
          <div class="nav-icon">
            ${Icons.get('requests', { active: activeTab === 'requests', size: 22 })}
          </div>
          <span class="nav-label">Requests</span>
        </div>

        <!-- Add Waste (Prominent Elevated Action) -->
        <div class="nav-item nav-item--prominent ${activeTab === 'add-waste' ? 'active' : ''}" data-nav="add-waste" role="button" tabindex="0">
          <div class="prominent-circle" title="Add Waste">
            ${Icons.get('plus', { active: true, size: 26 })}
          </div>
          <span class="nav-label">Add Waste</span>
        </div>

        <!-- Collectors Directory -->
        <div class="nav-item ${activeTab === 'collectors' ? 'active' : ''}" data-nav="collectors" role="button" tabindex="0">
          <div class="nav-icon">
            ${Icons.get('collectors', { active: activeTab === 'collectors', size: 23 })}
          </div>
          <span class="nav-label">Collectors</span>
        </div>

        <!-- Profile -->
        <div class="nav-item ${activeTab === 'profile' ? 'active' : ''}" data-nav="profile" role="button" tabindex="0">
          <div class="nav-icon">
            ${Icons.get('profile', { active: activeTab === 'profile', size: 23 })}
          </div>
          <span class="nav-label">Profile</span>
        </div>
      </nav>
    `;
  },

  // Collector Card Component
  renderCollectorCard(collector) {
    const isAvailable = collector.availability === 'available';
    const isBusy = collector.availability === 'busy';
    const badgeClass = isAvailable ? 'badge-available' : (isBusy ? 'badge-busy' : 'badge-offline');
    const badgeText = isAvailable ? 'Available' : (isBusy ? 'Busy' : 'Offline');

    const acceptedPills = collector.acceptedCategories.map(catId => {
      const cat = MockData.categories.find(c => c.id === catId);
      return `<span style="font-size: 11px; padding: 2px 8px; border-radius: var(--radius-full); background: #F1F7F5; color: var(--color-brand-dark); font-weight: 500;">
        ${cat ? cat.name : catId}
      </span>`;
    }).join('');

    return `
      <div class="collector-item-card" data-collector-id="${collector.id}">
        <div class="collector-card-main">
          <img src="${collector.avatar}" alt="${collector.name}" class="collector-avatar" loading="lazy">
          <div class="collector-info">
            <div class="collector-name-row">
              <span class="collector-name">${collector.name}</span>
              ${collector.verified ? `<span class="collector-verified-icon" title="Verified Collector">${Icons.get('shield-check', { size: 16, active: true })}</span>` : ''}
              <span class="badge ${badgeClass}" style="margin-left: auto;">
                <span class="badge-dot"></span>
                ${badgeText}
              </span>
            </div>
            <div class="collector-meta-row">
              <span style="display: flex; align-items: center; gap: 3px; font-weight: 600; color: #D97706;">
                ★ ${collector.rating} <span style="font-weight: 400; color: var(--color-text-muted);">(${collector.reviewCount})</span>
              </span>
              <span>•</span>
              <span style="display: flex; align-items: center; gap: 2px;">
                ${Icons.get('location', { size: 13 })} ${collector.distanceKm} km
              </span>
              <span>•</span>
              <span>${collector.completedCollections} pickups</span>
            </div>
            <div style="font-size: 12px; color: var(--color-text-secondary); margin-top: 4px;">
              ${collector.rateCard}
            </div>
          </div>
        </div>

        <div style="display: flex; gap: 6px; flex-wrap: wrap; align-items: center;">
          <span style="font-size: 11px; color: var(--color-text-muted); font-weight: 600;">Accepts:</span>
          ${acceptedPills}
        </div>

        <div class="collector-actions-row">
          <button class="btn btn-outline btn-sm collector-profile-btn" data-collector-id="${collector.id}" style="flex: 1;">
            Profile
          </button>
          <button class="btn btn-secondary btn-sm collector-chat-btn" data-collector-id="${collector.id}" title="Chat">
            ${Icons.get('chat', { size: 16 })} Chat
          </button>
          <button class="btn btn-secondary btn-sm collector-call-btn" data-collector-id="${collector.id}" title="Call">
            ${Icons.get('phone', { size: 16 })} Call
          </button>
          <button class="btn btn-primary btn-sm collector-book-btn" data-collector-id="${collector.id}" style="flex: 1.2;">
            Book Pickup
          </button>
        </div>
      </div>
    `;
  },

  // Skeleton Loaders
  renderCollectorSkeletons(count = 3) {
    let html = '';
    for (let i = 0; i < count; i++) {
      html += `
        <div class="collector-item-card" style="opacity: 0.85;">
          <div style="display: flex; gap: 12px; align-items: center;">
            <div class="skeleton skeleton-circle" style="width: 52px; height: 52px;"></div>
            <div style="flex: 1;">
              <div class="skeleton skeleton-text" style="width: 60%;"></div>
              <div class="skeleton skeleton-text" style="width: 40%; height: 12px;"></div>
              <div class="skeleton skeleton-text" style="width: 80%; height: 10px;"></div>
            </div>
          </div>
          <div style="display: flex; gap: 8px; margin-top: 10px;">
            <div class="skeleton" style="flex: 1; height: 34px; border-radius: var(--radius-sm);"></div>
            <div class="skeleton" style="flex: 1; height: 34px; border-radius: var(--radius-sm);"></div>
          </div>
        </div>
      `;
    }
    return html;
  },

  // Empty State
  renderEmptyState({ icon = 'recycle', title = 'No items found', desc = '', buttonLabel = '', buttonAction = '' } = {}) {
    return `
      <div class="empty-state">
        <div class="empty-state-icon">
          ${Icons.get(icon, { size: 36, active: true })}
        </div>
        <h3 class="empty-state-title">${title}</h3>
        ${desc ? `<p class="empty-state-desc">${desc}</p>` : ''}
        ${buttonLabel ? `<button class="btn btn-primary btn-sm empty-state-btn" data-action="${buttonAction}">${buttonLabel}</button>` : ''}
      </div>
    `;
  },

  // Toast Notification
  showToast(message, type = 'info') {
    const container = document.getElementById('toast-container');
    if (!container) return;

    const toast = document.createElement('div');
    toast.className = `toast toast-${type}`;
    
    let iconName = 'check';
    if (type === 'error') iconName = 'close';
    if (type === 'warning') iconName = 'help';

    toast.innerHTML = `
      <div style="color: inherit; flex-shrink: 0;">
        ${Icons.get(iconName, { size: 18, active: true })}
      </div>
      <div style="flex: 1; font-weight: 500;">${message}</div>
    `;

    container.appendChild(toast);

    setTimeout(() => {
      toast.style.opacity = '0';
      toast.style.transform = 'translateY(-10px)';
      toast.style.transition = 'all 200ms ease';
      setTimeout(() => toast.remove(), 200);
    }, 3200);
  },

  // Bottom Sheet Modal
  showBottomSheet(title, htmlContent) {
    const backdrop = document.getElementById('sheet-backdrop');
    const sheet = document.getElementById('bottom-sheet');
    const titleEl = document.getElementById('sheet-title');
    const contentEl = document.getElementById('sheet-content');

    if (!backdrop || !sheet) return;

    titleEl.textContent = title;
    contentEl.innerHTML = htmlContent;

    backdrop.classList.add('active');
    sheet.classList.add('active');
  },

  closeBottomSheet() {
    const backdrop = document.getElementById('sheet-backdrop');
    const sheet = document.getElementById('bottom-sheet');
    if (backdrop) backdrop.classList.remove('active');
    if (sheet) sheet.classList.remove('active');
  }
};
