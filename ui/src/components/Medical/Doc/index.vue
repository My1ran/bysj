<template>
  <div>
    <svg-icon icon-class="question" @click="goto" />
  </div>
</template>

<script>
export default {
  name: 'MedicalDoc',
  data() {
    return {
      url: 'http://doc.medical.vip/medical-vue'
    }
  },
  methods: {
    goto() {
      window.open(this.url)
    }
  }
}
</script>