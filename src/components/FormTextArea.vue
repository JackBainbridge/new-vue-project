<script setup>
    const {modelValue, label, type, placeholder, rows, error} = defineProps([
        'modelValue', 'label', 'type', 'placeholder', 'rows', 'error' ])

    const emit = defineEmits(['update:modelValue', 'blur'])
    const handleUpdate = (event) => {
        emit('update:modelValue', event.target.value)
    }
    
    const handleFocus = (event) => {
        event.target.classList.add('focus')
    }
</script>

<template>
    <div class="form-textarea">
        <label :for="label" class="form-label">{{ label }}</label>
        <textarea class="textarea"
            :type="type"
            :id="label"
            :placeholder="placeholder"
            :value="modelValue"
            @input="handleUpdate"
            @focus="handleFocus"
            @blur="$emit('blur', $event)"
            :rows="rows"
            :class="{ 'error': error }"
        ></textarea>
        <span v-if="error" class="error-message">{{ error }}</span>
    </div>
</template>


<style scoped>
.form-textarea {
  display: flex;
  flex-direction: column; /* Stack label and input vertically */
  margin-bottom: 1rem; /* Add spacing between fields */
}

.form-label {
  margin-bottom: 0.5rem; /* Add spacing between label and input */
  font-weight: bold; /* Optional: Make the label bold */
}

input {
  padding: 0.5rem;
  border: 1px solid #ccc;
  border-radius: 4px;
}

input.error {
  border-color: red; /* Highlight input border in red if there's an error */
}

.error-message {
  color: red;
  font-size: 0.875rem; /* Optional: Smaller font size for error messages */
  margin-top: 0.25rem; /* Add spacing above the error message */
}
</style>