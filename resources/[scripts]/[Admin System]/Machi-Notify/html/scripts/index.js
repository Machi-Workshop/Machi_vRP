import CONFIG from './config.js';

const ANIMATE_KEY = 'bounceInRight';

const app = new Vue({
  el: '#app',
  name: 'app',
  data: {
    debug: CONFIG.isDebug,
    debugNotifyText: '공지 내용',
    debugNotifyAuthor: '공지 작성자',
    notifyRebootTime: '리부팅 시간',
    rebootNotifyId: '',
    notify: [],
  },
  mounted() {
    document.getElementById('app').classList.add('visable');

    // Add NUI Event Listener
    window.addEventListener('message', (event) => {
      const item = event.data;
      if (this[item.type]) {
        this[item.type](item);
      }
    });

    // this.WELCOME_NOTICE();
  },
  methods: {
    ADMIN_MESSAGE: function(message) {
      return this.ON_ADD_NOTIFY({
        notify: {
          theme: 'notify-admin',
          icon: 'admin.png',
          appName: '관리자 알림',
          title: '관리자가 안내드립니다.',
          content: message.content,
          author: message.username,
          audio: '/html/sounds/welcome.ogg'
        },
      });
    },
    REBOOT_MESSAGE: function(reboot) {
      let secounds = Number(reboot.rebootNotifyTime) * 60;

      const id = this.ON_ADD_NOTIFY({
        notify: {
          theme: 'notify-reboot',
          icon: 'reboot.png',
          title: '곧 서버가 리부팅됩니다.',
          content: `안전한 위치에서 접속을 종료하여 주십시오.
            <br /><span class="reboot-timer"></span>시간 계산 중`,
          appName: '리부팅 알림',
          time: (Number(reboot.rebootNotifyTime) + 1) * 60 * 1000
        }
      });

      this.rebootNotifyId = id;

      const rebootNotify = this.notify.find((e) => e.id === id);
      let rebootNotifyString = "";

      const interval = setInterval(() => {
        secounds -= 1;
        const rebootMinutes = Math.floor(secounds / 60);
        const rebootSecounds = secounds - (rebootMinutes * 60);

        rebootNotifyString = `${rebootMinutes.toString().padStart(2, "0")}:${rebootSecounds.toString().padStart(2, "0")}`;
        const rawHtml = `안전한 위치에서 접속을 종료하여 주십시오.<br /><span class="reboot-timer">${rebootNotifyString}</span> 뒤 리부팅 예정`;

        rebootNotify.content = rawHtml;

        if (secounds <= 0) {
          clearInterval(interval);
          rebootNotify.content = `안전한 위치에서 접속을 종료하여 주십시오.<br /><span class="reboot-timer"></span> <b>곧 리부팅 됩니다!</b>`;
        }
      }, 1000);
    },
    REBOOT_CANCEL_MESSAGE: function() {
      this.ON_REMOVE_NOTIFY({
        notify: {
          id: this.rebootNotifyId,
        },
      });
    },
    // Debug Layer
    DEBUG_ADD_ADMIN: function() {
      return this.ON_ADD_NOTIFY({
        notify: {
          theme: 'notify-admin',
          icon: 'admin.png',
          appName: '관리자 알림',
          title: '관리자가 안내드립니다.',
          content: this.debugNotifyText,
          author: this.debugNotifyAuthor,
          audio: '/html/sounds/welcome.ogg'
        },
      });
    },
    DEBUG_ADD_REBOOT: function({reboot}) {
      let secounds = this.notifyRebootTime * 60;

      const id = this.ON_ADD_NOTIFY({
        notify: {
          theme: 'notify-reboot',
          icon: 'reboot.png',
          title: '곧 서버가 리부팅됩니다.',
          content: `안전한 위치에서 접속을 종료하여 주십시오.
            <br /><span class="reboot-timer"></span>시간 계산 중`,
          appName: '리부팅 알림',
          time: (Number(this.notifyRebootTime) + 1) * 60 * 1000
        }
      });

      this.rebootNotifyId = id;

      const interval = setInterval(() => {
        const rebootNotify = this.notify.find((e) => e.id === id);
        if (rebootNotify === undefined || rebootNotify === null) {
          // 공지가 제거됨
          clearInterval(interval);
          return;
        }

        secounds -= 1;

        const rebootMinutes = Math.floor(secounds / 60);
        const rebootSecounds = secounds - (rebootMinutes * 60);

        this.notifyRebootString = `${rebootMinutes.toString().padStart(2, "0")}:${rebootSecounds.toString().padStart(2, "0")}`;
        const rawHtml = `안전한 위치에서 접속을 종료하여 주십시오.<br /><span class="reboot-timer">${this.notifyRebootString}</span> 뒤 리부팅 예정`;

        rebootNotify.content = rawHtml;

        if (secounds <= 0) {
          clearInterval(interval);
          rebootNotify.content = `안전한 위치에서 접속을 종료하여 주십시오.<br /><span class="reboot-timer"></span> <b>곧 리부팅 됩니다!</b>`;
        }
      }, 1000);
    },
    DEBUG_REMOVE_REBOOT: function() {
      this.ON_REMOVE_NOTIFY({
        notify: {
          id: this.rebootNotifyId,
        },
      });
    },
    // Common Layer
    ON_ADD_NOTIFY: function({ notify }) {
      // 알림 추가
      const id = this.notify.length + 1;

      try {
        const audioPath = notify.audio === undefined ? CONFIG.soundLocation : notify.audio;
        const audio = new Audio(audioPath);
        audio.play();
      } catch (error) {
        console.error(`Could not play audio: ${error}`);
      }
      

      this.notify.push({
        id,
        theme: [notify.theme, ANIMATE_KEY],
        icon: notify.icon,
        title: notify.title,
        content: notify.content,
        author: notify.author,
        appName: notify.appName,
        appIcon: notify.appIcon,
      });

      setTimeout(() => {
        const notifyItem = this.notify.find((e) => e.id === id);
        if (notifyItem !== null && notifyItem !== undefined) {
          const theme = notifyItem.theme;
          const index = theme.findIndex((e) => e === ANIMATE_KEY);
          if (index >= 0)  {
            theme.splice(index, 1);
          }
        }
      }, CONFIG.animationMS);

      // 일정 시간이 지나거나, 요청한 시간에 따라 삭제
      setTimeout(() => {
        this.notify.find((e) => e.id === id).theme.push('fadeOut');
        
        setTimeout(() => {
          const currentNotifyIdx = this.notify.findIndex((e) => e.id === id);
          if (currentNotifyIdx >= 0 ) {
            this.notify.splice(currentNotifyIdx, 1);
          }
        }, CONFIG.animationMS);
      }, notify.time === undefined ? 5000 : notify.time);

      return id;
    },
    ON_REMOVE_NOTIFY: function({notify}) {
      const notifyLocation = this.notify.findIndex((e) => e.id === notify.id);
      console.log(notifyLocation);

      if (notifyLocation >= 0) {
        // Notify Exists
        this.notify.splice(notifyLocation, 1);
      }
    },
  },
});
