<script setup>
import { ref, computed } from 'vue';
import sendEmail from '@/services/emailService';
import FormInput from '@/components/FormInput.vue';
import FormTextArea from '@/components/FormTextArea.vue';

// const toast = useToast();
// const router = useRouter();
const title = ref('Contact');
const showForm = ref(true);
const successMessage = ref('');
const errorMessage = ref('');

const initialValues = {
  initialValues: {
    name: '',
    subject: '',
    email: '',
    message: ''
  }
};

const initalTouched = {
  initialTouched: {
    name: false,
    subject: false,
    email: false,
    message: false
  }
};

const formValues = ref({ ...initialValues });
const touched = ref({ ...initalTouched });
const errors = ref({
  name: null,
  subject: null,
  email: null,
  message: null
});

// Form field validation
const formErrors = ref({
  name: computed(() => {
    if (!formValues.value.name && touched.value.name) {
      return 'Name is required';
    }
    return null;
  }),
  subject: computed(() => {
    if (!formValues.value.subject && touched.value.subject) {
      return 'Subject is required';
    }
    return null;
  }),
  email: computed(() => {
    if (touched.value.email) { // Only validate if the field has been touched
      if (!formValues.value.email) {
        return 'Email is required';
      }
      if (!validateEmail(formValues.value.email)) {
        return 'Invalid email address';
      }
    }
    return null;
  }),
  message: computed(() => {
    if (!formValues.value.message && touched.value.message) {
      return 'Message is required';
    }
    return null;
  })
});

// Validate email via regex
const validateEmail = (email) => {
  const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return re.test(email);
};

const handleInput = (field, value) => {
  formValues.value[field] = value;
  errors.value[field] = null;
};

const setTouched = (field) => {
  touched.value[field] = true;
};

const isFormValid = computed(() => {
  const allFieldsTouched = Object.values(touched.value).every((touched) => touched);
  const allFieldsValid = Object.values(formErrors.value).every((error) => error === null);
  const allFieldsFilled = Object.values(formValues.value).every((value) => value !== '' || value !== null);
  return allFieldsTouched && allFieldsValid && allFieldsFilled;
});

const handleSubmitForm = async () => {
  try {
    await sendEmail(formValues.value);
    successMessage.value = 'Email sent successfully!';
    errorMessage.value = '';
    resetForm();
  } catch (error) {
    errorMessage.value = 'Failed to send email. Please try again.';
    successMessage.value = '';
  }
};

const handleReset = () => {
  formValues.value = { ...initialValues };
  touched.value = { ...initalTouched };
  errors.value = {};
  successMessage.value = '';
  errorMessage.value = '';
  showForm.value = true;
};

function onFileSelected($event) {
  const file = $event.target.files[0];
  if (file) {
    formValues.value.file = file;
  } else {
    formValues.value.file = null;
  }
};
</script>

<template>
  <div class="container-fluid w-25">
    <div class="container-form">
      <form v-if="showForm" @submit.prevent="handleSubmitForm" enctype="multipart/form-data">
        <h1 class="header2 mb-4">{{ title }}</h1>
        <div class="label mb-3">
          <FormInput
            label="Name"
            type="text"
            placeholder="Enter your name"
            v-model="formValues.name"
            @input="handleInput('name', $event.target.value)"
            @blur="setTouched('name')"
          />
          <span v-if="formErrors.name" class="text-danger">
            <font-awesome-icon :icon="['fas', 'triangle-exclamation']" />
            {{ formErrors.name }}
          </span>
        </div>
        <div class="label mb-3">
          <FormInput
            label="Subject"
            type="text"
            placeholder="Enter subject"
            v-model="formValues.subject"
            @input="handleInput('subject', $event.target.value)"
            @blur="setTouched('subject')"
          />
          <span v-if="formErrors.subject" class="text-danger">
            <font-awesome-icon :icon="['fas', 'triangle-exclamation']" />
            {{ formErrors.subject }}
          </span>
        </div>
        <div class="label mb-3">
          <FormInput
            label="Email"
            type="email"
            placeholder="Enter your email address"
            v-model="formValues.email"
            @input="handleInput('email', $event.target.value)"
            @blur="setTouched('email')"
          />
          <span v-if="formErrors.email" class="text-danger">  
            <font-awesome-icon :icon="['fas', 'triangle-exclamation']" />
            {{ formErrors.email }}
          </span>
        </div>
        <div class="label mb-3">
          <FormTextArea
            label="Message"
            rows=5
            placeholder="Enter your message here..."
            v-model="formValues.message"
            @input="handleInput('message', $event.target.value)"
            @blur="setTouched('message')"
          />
          <span v-if="formErrors.message" class="text-danger">  
            <font-awesome-icon :icon="['fas', 'triangle-exclamation']" />
            {{ formErrors.message }}
          </span>
        </div>
        <div class="form-group label mb-3">
          <label for="file">Attachment (PDF, JPG, PNG only)</label>
          <input type="file" class="form-control" id="file" @change='onFileSelected' accept=".pdf, .jpg, .jpeg, .png"/>
        </div>
        <div class = "d-flex justify-content-end">
          <img v-if="formValues.file" :src="URL.createObjectURL(formValues.file)" alt="Selected file" class="img-thumbnail" />
          <button class="btn btn-dark" type='submit' :disabled='!isFormValid'>Send</button>
          <button class="btn btn-danger" type='button' @click='handleReset'>Reset</button>
        </div>
        <p v-if='successMessage' class='text-success'>{{ successMessage }}</p>
        <p v-if='errorMessage' class='text-danger'>{{ errorMessage }}</p>

      </form>
    </div>
  </div>
</template>
<style scoped>
.header2 {
  color: var(--white);
  text-align: center;
  font-size: 250%;
}

.label {
  color: var(--white);
  font-size: 125%;
}

.text-danger {
  color: var(--red);
}

.text-success {
  color: var(--green);
}
</style>